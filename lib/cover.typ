#import "metadata.typ": *

// KIT-Logo Gestaltungsrichtlinien: https://kit-cd.sts.kit.edu/downloads/Gestaltungsrichtlinien_Kurzfassung_Augus.pdf

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
					text(font: "Liberation Sans", weight: "bold", size: 24pt)[#metadata.title]
				)
			),

			block(width: 50%)[
				#text(size: 12pt)[
					#metadata.thesisType's Thesis
					of
				]
			],

			text(font: "Liberation Sans", weight: "bold", size: 18pt)[#metadata.author],

			text(size: 12pt)[
				at the#linebreak()#metadata.department#linebreak()#metadata.institute
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
					[#metadata.examiners.at(0)],

					[Second examiner:],
					[#metadata.examiners.at(1)],

					[First advisor:],
					[#metadata.supervisors.at(0)],

					[Second advisor:],
					[#metadata.supervisors.at(1)],
				),
			),

			// Wikipedia recommends an "en dash" for a range of (date) values, and not just a `-` hyphen, see https://en.wikipedia.org/wiki/Dash#Ranges_of_values
			text()[#metadata.startDate.display(dateFormat) #sym.dash.en #metadata.endDate.display(dateFormat)]
		)
	)
)

#block(inset: 5pt)[
	#text(
		font: "Liberation Sans",
		size: 8pt
	)[KIT – The Research University in the Helmholtz Association #h(1fr)] #text(font: "Liberation Sans", weight: "bold", size: 22pt)[www.kit.edu]
]