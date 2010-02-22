# Encoding: UTF-8

{fileTypes: ["blog.html"],
 firstLineMatch: "^Type: Blog Post \\(HTML\\)",
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b.*?>
	|<!--(?!.*--\s*>)
	|\{\{?(?<_2>if|foreach|capture|literal|foreach|php|section|strip)
	|\{\s*(?<_3>$|\?>\s*$|\/\/|\/\*(?<_4>.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^(?!.*?<!--).*?--\s*>
	|\{\{?\/(?<_2>if|foreach|capture|literal|foreach|php|section|strip)
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
     /^(?<_1>[Tt]itle|[Dd]ate|[Bb]asename|[Ss]lug|[Kk]eywords|[Bb]log|[Tt]ype|[Ll]ink|[Pp]ost|[Tt]ags|[Cc]omments|[Pp]ings?|[Cc]ategory|[Ss]tatus|[Ff]ormat)(?<_2>:)\s*(?<_3>.*)$\n?/,
    name: "meta.header.blog"},
   {match: /^(?<_1>[A-Za-z0-9]+):\s*(?<_2>.*)$\n?/,
    name: "invalid.illegal.meta.header.blog"},
   {begin: /^(?![A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    name: "text.html",
    patterns: 
     [{match: /^✂-[✂-]+$\n/, name: "meta.separator.blog"},
      {include: "text.html.basic"}]}],
 scopeName: "text.blog.html",
 uuid: "E46F5C50-5D16-4B5C-8FBB-686BD3768284"}
