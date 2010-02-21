# Encoding: UTF-8

{firstLineMatch: "^Format:\\s*(?i:complete)\\s*$",
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b.*?>
	|<!--(?!.*-->)
	|\{\s*(?<_2>$|\?>\s*$|\/\/|\/\*(?<_3>.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^\s*-->
	|(?<_2>^|\s)\}
	)/,
 keyEquivalent: "^~M",
 name: "MultiMarkdown",
 patterns: 
  [{begin: /^(?<_1>[A-Za-z0-9]+)(?<_2>:)\s*/,
    beginCaptures: 
     {1 => {name: "keyword.other.multimarkdown"},
      2 => {name: "punctuation.separator.key-value.multimarkdown"}},
    end: "^$|^(?=[A-Za-z0-9]+:)",
    name: "meta.header.multimarkdown",
    patterns: 
     [{comment: 
        "The reason for not setting scopeName = \"string.unquoted\" \n\t\t\t\t\t\t(for the parent rule) is that we do not want\n\t\t\t\t\t\tnewlines to be marked as string.unquoted",
       match: /.+/,
       name: "string.unquoted.multimarkdown"}]},
   {begin: /^(?!=[A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    name: "meta.content.multimarkdown",
    patterns: [{include: "text.html.markdown"}]}],
 scopeName: "text.html.markdown.multimarkdown",
 uuid: "F5E04BF4-69A9-45AE-9205-B3F3C2B00130"}
