#let todo-counter = counter("todo")

// Shows a ToDo as a footnote.
// Usage: `#todo[Message]`
#let todo(body) = {
		let color = rgb("#FF4500")
		if body == [] {
			body = "TODO"
		}
		footnote(
			numbering: (footnote-counter) => {
				text(fill: color, "TODO#" + str(footnote-counter))
			},
			text(fill: color)[#body]
		)
}

// Shows a ToDO message as a block.
// Usage: `todo-block[Message]`
#let todo-block(body) = {
	block(
		fill: color.hsv(30deg, 70%, 100%),
		inset: 5pt,
		radius: 3pt,
		breakable: true,
		[
			*TODO*

			#body
		]
	)
}