// KIT-Logo Gestaltungsrichtlinien: https://kit-cd.sts.kit.edu/downloads/Gestaltungsrichtlinien_Kurzfassung_Augus.pdf

#let cover(
	title: "Answering the Question of Life by Interpreting the Number 42",
	thesisType: "Master", // Bachelor or Master
	author: "John Doe",
	startDate: datetime(year: 2025, month: 04, day: 29),
	endDate: datetime(year: 2024, month: 10, day: 29),
	examiners: ("Prof. Alice Smith", "Prof. Bob Johnson"),
	supervisors: ("Dr. Carol White", "Dr. David Brown"),
	department: "Department of Informatics",
	institute: "Institute of Computer Engineering",
) = [
	#set page(
		margin: (left: 50pt, rest: 30pt),
	)

	#let dateFormat = "[day]. [month repr:long] [year]"

	#rect(
		width: 100%,
		height: 95%,
		radius: (
			top-right: 15pt,
			bottom-left: 15pt,
		),
		stroke: rgb("#8a8a8a") + 1pt,
		inset: 20pt,
		align(center,
		stack(
			dir: ttb, spacing: 1fr,
			align(left, grid(
				columns: (auto),
				rows: (auto),
				[#image("KIT_Logo.svg", width: 115pt)],
			)),

			pad(20pt,
			block(width: 75%,
			text(font: "Liberation Sans", weight: "bold", size: 24pt)[#title]
		)
	),

	block(width: 50%)[
		#text(size: 12pt)[
			#thesisType's Thesis
			of
		]
	],

	text(font: "Liberation Sans", weight: "bold", size: 18pt)[#author],

	text(size: 12pt)[
		at the#linebreak()#department#linebreak()#institute
	],

	text(
		size: 12pt,
		grid(
			columns: (auto, auto),
			rows: (auto),
			align: (left, left),
			row-gutter: 1em,
			column-gutter: 2em,
			[First examiner:],
			[#examiners.at(0)],

			[Second examiner:],
			[#examiners.at(1)],

			[First advisor:],
			[#supervisors.at(0)],

			[Second advisor:],
			[#supervisors.at(1)],
		),
	),

	// Wikipedia recommends an "en dash" for a range of (date) values, and not just a `-` hyphen, see https://en.wikipedia.org/wiki/Dash#Ranges_of_values
	text()[#startDate.display(dateFormat) #sym.dash.en #endDate.display(dateFormat)]
)
	)
)

#block(inset: 5pt)[
	#text(
		font: "Liberation Sans",
		size: 8pt
	)[KIT – The Research University in the Helmholtz Association #h(1fr)] #text(font: "Liberation Sans", weight: "bold", size: 22pt)[www.kit.edu]
]
]
