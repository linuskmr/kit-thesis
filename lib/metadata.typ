#let metadata = toml("../metadata.toml")

// If you want to use a different file format for the metadata than toml,
// you have to manually convert date strings to typst dates using the following function.
// From https://github.com/typst/typst/issues/4107#issuecomment-3462660389
#let parseDate(d) = toml(bytes("date = " + d)).date