# Encoding: UTF-8

{fileTypes: ["blog.html"],
 firstLineMatch: "^Type: Blog Post \\(HTML\\)",
 foldingStartMarker: 
  /(?x)
	(<(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b.*?>
	|<!--(?!.*--\s*>)
	|\{\{?(if|foreach|capture|literal|foreach|php|section|strip)
	|\{\s*($|\?>\s*$|\/\/|\/\*(.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(<\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^(?!.*?<!--).*?--\s*>
	|\{\{?\/(if|foreach|capture|literal|foreach|php|section|strip)
	|^[^{]*\}
	)/,
 keyEquivalent: "^~B",
 name: "Blog — HTML",
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
    name: "text.html",
    patterns: 
     [{match: /^✂-[✂-]+$\n/, name: "meta.separator.blog"},
      {include: "text.html.basic"}]}],
 scopeName: "text.blog.html",
 uuid: "E46F5C50-5D16-4B5C-8FBB-686BD3768284"}
