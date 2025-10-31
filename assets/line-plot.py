# Reads a CSV in the format `label,x,y`, generates a line plot as SVG, and computes basic statistics as CSV.

from pathlib import Path
import matplotlib.pyplot as plt
import pandas as pd
import sys

try:
	csv_path = sys.argv[1]
except IndexError:
	print("Usage: python plot-csv.py <path_to_csv>")
	sys.exit(1)

df = pd.read_csv(csv_path)

plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.size'] = 18

for label, values in df.groupby(df.columns[0]):
	x = values.iloc[:, 1]
	y = values.iloc[:, 2]
	plt.plot(x, y, label=label)

plt.grid()
plt.xlabel(df.columns[1])
plt.ylabel(df.columns[2])
plt.legend()
plt.tight_layout()

svg_path = Path(csv_path).with_suffix(".svg")
plt.savefig(svg_path)

stats_path = Path(csv_path).with_suffix(".stats.csv")
stats = df.groupby(df.columns[0]).agg(
	Mean=(df.columns[2], 'mean'),
	Median=(df.columns[2], 'median'),
	Stddev=(df.columns[2], 'std'),
	Min=(df.columns[2], 'min'),
	Max=(df.columns[2], 'max'),
	Count=(df.columns[2], 'count'),
).round(2).reset_index().to_csv(stats_path, index=False)
