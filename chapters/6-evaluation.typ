#import "../lib/todo.typ": todo, todo-block

= Evaluation <sec:evaluation>

@fig:evaluation:os-preference shows the preference of using different operating systems over time, while @tab:evaluation:os-preference-stats shows corresponding statistical data.

#todo-block[Replace with actual content]

#figure(
	image("../assets/os-preference.line-plot.svg", width: 60%),
	caption: [Preference of using different operating systems over the years.]
) <fig:evaluation:os-preference>

#let os-preference-stats = csv("../assets/os-preference.line-plot.stats.csv")
#figure(
	table(
		columns: os-preference-stats.at(0).len(),
		table.header(..os-preference-stats.at(0)),
		..os-preference-stats.slice(1).flatten(),
	),
	caption: [Statistical data of using different operating systems over time.]
) <tab:evaluation:os-preference-stats>