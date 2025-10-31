#import "lib/metadata.typ": *

// Setup
#set document(title: metadata.thesisType + ": " + metadata.title, author: metadata.author, keywords: metadata.keywords)
#set page("a4")

// Use a custom citation style for inline cites (`#cite(<REFERENCE>, form: "author")`) to limit the number of author names shown to 3 before showing "et al." instead.
#set cite(style: "lib/cite-style-inline-max-3-authors.csl")

// Heading customization
// We use `block` instead of `pad` because `block` omits the margin if it is at the top of the page
#show heading.where(level: 1): h => {
	// For some reason, this results in the error `pagebreaks are not allowed inside of containers`.
	// It works if we do it in a separate show rule, however (see below).
	// pagebreak(to: "odd", weak: true)
	text(size: 24pt, {
		if h.numbering != none and not h.body.text.contains("Appendix") {
			v(3em)
			par("Chapter " + counter(heading).display(h.numbering))
		}
		par(h.body)
		v(1em)
	})
}
#show heading.where(level: 1): h => block(above: 4em, below: 1em, text(size: 24pt, h))
#show heading.where(level: 2): h => block(above: 1.75em, below: 1em, text(size: 16pt, h))
#show heading.where(level: 2): h => text(size: 16pt, h)
// #show heading.where(level: 4): set heading(numbering: none)
#show heading.where(level: 5): set heading(numbering: none)

#show heading.where(level: 1): it => [
    #pagebreak(to: "odd", weak: true)
    #it
]


#show raw.where(block: true): it => {
	set align(left)
	set text(size: 8pt)
	block(
		fill: luma(240),
		inset: 7pt,
		radius: 2pt,
		width: 100%,
		it
	)
}


// #show link: set text(fill: blue)
// #show link: underline

#set quote(block: true)
#show quote: it => block(
  stroke: (left: 2pt + gray),
	it
)


// Title page
#include "lib/cover.typ"
#pagebreak()
#pagebreak()


// Front matter pages

#set par(justify: true)

// Alternating margins on the inner and outer side of the page
// See https://typst.app/docs/guides/page-setup-guide/#alternating-margins
#set page(margin: (inside: 2.54cm, outside: 4.09222cm, y: 5.2cm))

#set text(size: 12pt, font: "libertinus serif") // The official template uses "CMU Serif"
#set text(costs: (runt: 200%, widow: 200%, orphan: 200%)) // Avoid runts (ending a paragraph with a line with a single word), widows (leaving a single line of paragraph on the next page) and orphans (leaving single line of paragraph on the previous page)


// Statutory Declaration
#include "lib/statutory-declaration.typ"
#pagebreak()


// Begin numbering
#set page(numbering: "i")


// Abstract
#include "chapters/0-abstract.typ"



// Table of contents
= Contents

#show outline.entry.where(level: 1): set text(weight: "bold")
#show outline.entry.where(level: 1): set block(above: 1.5em)
#show outline.entry.where(level: 2): set block(above: 0.8em)
#show outline.entry.where(level: 1): set outline.entry(fill: none)

#outline(title: none, depth: 2) // Using a title here removes it (i.e. "table of contents") from the table of contents itself



// = List of Figures

// #show outline.entry.where(level: 1): set text(weight: "regular")
// #outline(title: none, target: figure.where(kind: image)) // Using a title here removes it from the table of contents itself



// Main content about to start.
// Although a set rule auto-injects pagebreaks before level 1 headings,
// there have to be a few things changed before the main content starts,
// e.g. change page numbering.
#pagebreak(weak: true)


// Start heading numbering
#set heading(numbering: "1.1")

// Equation numbering
#set math.equation(numbering: "(1)")

// Reset page numbering and use normal numbers (instead of the roman numbers for the front matter)
// We set it to 0 because every level 1 heading has an additional empty page in front of it.
// This is a hack and is not fully correct, since the page before the first section (i.e. "1 Introduction") is a fully empty page,
// even without showing the page number, although it should be shown.
#counter(page).update(1)


// We have our own function for displaying the page number together with the current section in the page header (see below).
// "If an explicit header is given for top-aligned numbering, the numbering is ignored" (https://typst.app/docs/reference/layout/page/#parameters-numbering).
// However, setting numbering to `none` removes the page numbers from the PDF metadata.
#set page(numbering: "1", number-align: top)

// Show the current section in the top left/right corner
// From https://github.com/talal/ilm/blob/main/lib.typ
#set page(
	header-ascent: 20%,
	header: context {
		// If the current page does not start a new chapter (no heading of level 1),
		// show a header with the current page number and section

		// Get current page number
		let monotonic_page_number = here().page()

		// If the current page starts a new chapter (heading level 1),
		// do not show a header, but a footer instead.
		let level-1-headings-on-page = query(heading)
			.filter(h => h.level == 1 and h.location().page() == monotonic_page_number)
			.sorted(key: h => h.level)
		if level-1-headings-on-page.len() > 0 {
			// current-heading = headings-on-page.first()
			return none
		}

		let current-heading = none
		let chapter = none
		if calc.odd(monotonic_page_number) {
			// Heading
			let headings-on-page = query(heading)
				.filter(h => h.level <= 2 and h.location().page() == monotonic_page_number)
				.sorted(key: h => h.level)
			let headings-before-page = query(heading)
				.filter(h => h.level <= 2 and h.location().page() < monotonic_page_number)
			
			// Find the chapter of the section we are currently in.
			if headings-before-page.len() > 0 {
				current-heading = headings-before-page.last()
			} else if headings-on-page.len() > 0 {
				current-heading = headings-on-page.first()
			}

			chapter = upper(text(style: "italic", {
				// Limit the heading numbers to two levels
				counter(heading).display((..nums) => {
					let nums = nums.pos()
					let count = calc.min(nums.len(), 2)
					nums.slice(0, count).map(str).join(".")
				})
				sym.space.en
				current-heading.body
			}))
		} else {
			// Chapter
			let headings-on-page = query(heading)
				.filter(h => h.level <= 1 and h.location().page() == monotonic_page_number)
				.sorted(key: h => h.level)
			let headings-before-page = query(heading)
				.filter(h => h.level <= 1 and h.location().page() < monotonic_page_number)

			// Find the chapter of the section we are currently in.
			if headings-before-page.len() > 0 {
				current-heading = headings-before-page.last()
			} else if headings-on-page.len() > 0 {
				current-heading = headings-on-page.first()
			}

			chapter = upper(text(style: "italic", {
				// Limit the heading numbers to two levels
				"Chapter"
				sym.space
				counter(heading).display((..nums) => {
					let nums = nums.pos()
					let count = calc.min(nums.len(), 1)
					nums.slice(0, count).map(str).join(".")
				})
				"."
				sym.space.en
				current-heading.body
			}))
		}
		// Alternative header design, although not compliant with the template:
		// let chapter = upper(text(size: 0.8em, {
		// 	counter(heading).display()
		// 	sym.space
		// 	current-heading.body
		// }))

		if current-heading.numbering != none {
			let header-content = none
			if calc.odd(monotonic_page_number) {
				header-content = (chapter, counter(page).display())
			} else {
				header-content = (counter(page).display(), chapter)
			}
			// The grid ensures that an overlong chapter title does not break the page number into a new line,
			// but instead the chapter title breaks.
			grid(
					columns: (1fr, auto),
					column-gutter: 2em,
					align: top,
					..header-content
				)
			// line(length: 100%, stroke: 0.5pt)
		}
	},
	footer-descent: 15%,
	footer: context {
		// Only show the footer if the current page starts a chapter,
		// i.e. has a level 1 heading.
		let monotonic_page_number = here().page()
		let level-1-headings-on-page = query(heading)
			.filter(h => h.level == 1 and h.location().page() == monotonic_page_number)
			.sorted(key: h => h.level)
		if level-1-headings-on-page.len() > 0 {
			return align(center)[#counter(page).display()]
		}
	}
)


#set table(
	stroke: (x, y) => if y == 0 {
		(bottom: 1pt)
	},
  inset: 2mm,
)
#show table.header: it => set text(weight: "bold")


// Main content
#include "chapters/1-introduction.typ"
#include "chapters/2-related-work.typ"
#include "chapters/3-background.typ"
#include "chapters/4-approach.typ"
#include "chapters/5-implementation.typ"
#include "chapters/6-evaluation.typ"
#include "chapters/7-discussion.typ"
#include "chapters/8-conclusion.typ"


// #counter(heading).update(0)
// #set heading(numbering: "A.1")

// #include "chapters/9-appendix.typ"


// Bibliography
// The default style (ieee) does not merge adjacent cites into one group of braces.
#set page(numbering: "1", number-align: bottom)
#bibliography("references.bib", style: "association-for-computing-machinery")
