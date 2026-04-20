.PHONY: all clean

DRAWIO_PDFS := $(wildcard *.drawio.pdf)
DRAWIO_SVGS := $(DRAWIO_PDFS:.drawio.pdf=.drawio.svg)

LINE_PLOT_CSVS := $(wildcard *.line-plot.csv)
LINE_PLOT_SVGS := $(LINE_PLOT_CSVS:.line-plot.csv=.line-plot.svg)
LINE_PLOT_STAT_CSVS := $(LINE_PLOT_CSVS:.line-plot.csv=.line-plot.stats.csv)

all: $(DRAWIO_SVGS) $(LINE_PLOT_SVGS) $(LINE_PLOT_STAT_CSVS)

%.drawio.svg: %.drawio.pdf
	pdftocairo -svg $< $@

%.line-plot.svg %.stats.csv: %.line-plot.csv line-plot.py
	python3 line-plot.py $<

clean:
	rm -f $(DRAWIO_SVGS) $(LINE_PLOT_SVGS) $(LINE_PLOT_STAT_CSVS)
