#import "@local/kit-thesis:0.1.0": kit-thesis, todo-block, todo

#show: kit-thesis.with(
	title: "Answering the Question of Life by Interpreting the Number 42",
	thesisType: "Master", // Bachelor or Master
	author: "John Doe",
	keywords: ("42", "Computer Science"),
	startDate: datetime(year: 2025, month: 04, day: 29),
	endDate: datetime(year: 2024, month: 10, day: 29),
	examiners: ("Prof. Alice Smith", "Prof. Bob Johnson"),
	supervisors: ("Dr. Carol White", "Dr. David Brown"),
	department: "Department of Informatics",
	institute: "Institute of Computer Engineering",
	researchGroup: "Operating Systems Group",
	abstract: "Your abstract",
	references: bibliography("references.bib")
)

#include "chapters/1-introduction.typ"
#include "chapters/2-related-work.typ"
#include "chapters/3-background.typ"
#include "chapters/4-approach.typ"
#include "chapters/5-implementation.typ"
#include "chapters/6-evaluation.typ"
#include "chapters/7-discussion.typ"
#include "chapters/8-conclusion.typ"

