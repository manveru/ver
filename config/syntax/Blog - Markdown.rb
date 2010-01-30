# Encoding: UTF-8

{fileTypes: ["blog.markdown", "blog.mdown", "blog.mkdn", "blog.md"],
 firstLineMatch: "^Type: Blog Post \\(Markdown\\)",
 foldingStartMarker: 
  /(?x)
	(<(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b.*?>
	|<!--(?!.*-->)
	|\{\s*($|\?>\s*$|\/\/|\/\*(.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(<\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^\s*-->
	|(^|\s)\}
	)/,
 keyEquivalent: "^~B",
 name: "Blog — Markdown",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.other.blog"},
      2 => {name: "punctuation.separator.key-value.blog"},
      3 => {name: "string.unquoted.blog"}},
    match: 
     /^([Tt]itle|[Dd]ate|[Bb]asename|[Ss]lug|[Kk]eywords|[Bb]log|[Tt]ype|[Ll]ink|[Pp]ost|[Tt]ags|[Cc]omments|[Pp]ings?|[Cc]ategory|[Ss]tatus|[Ff]ormat)(:)\s*(.*)$\n?/,
    name: "meta.header.blog"},
   {match: /^([A-Za-z0-9]+):\s*(.*)$\n?/,
    name: "invalid.illegal.meta.header.blog"},
   {begin: /^(?![A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    name: "text.html.markdown",
    patterns: 
     [{match: /^✂-[✂-]+$\n/, name: "meta.separator.blog"},
      {include: "text.html.markdown"}]}],
 scopeName: "text.blog.markdown",
 uuid: "6AA68B5B-18B8-4922-9CED-0E2295582955"}
