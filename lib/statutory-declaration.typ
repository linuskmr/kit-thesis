#let statutory-declaration(
	endDate: datetime(year: 2024, month: 10, day: 29),
) = [
	#v(10cm)

	#align(center)[*Statutory Declaration*]


	#line(length: 100%, stroke: (thickness: 0.5pt))

	I hereby declare that the work presented in this thesis is entirely my own and that I
	did not use any source or auxiliary means other than these referenced. This thesis
	was carried out in accordance with the Rules for Safeguarding Good Scientific
	Practice at Karlsruhe Institute of Technology (KIT).

	#v(1em)

	Karlsruhe, #endDate.display("[day].[month].[year]")

	// #v(2cm)
	//
	// #box(
	//   width: 175pt,
	//   [
	//     #line(length: 100%, stroke: (thickness: 1pt, dash: "dotted"))
	//     #align(center)[(#author)]
	//   ]
	// )
]
