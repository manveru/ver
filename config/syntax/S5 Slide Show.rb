# Encoding: UTF-8

{fileTypes: ["s5"],
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
 keyEquivalent: "^~S",
 name: "S5 Slide Show",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.other.s5"},
      2 => {name: "punctuation.separator.key-value.s5"},
      3 => {name: "string.unquoted.s5"}},
    match: /^(?<_1>[A-Za-z0-9]+)(?<_2>:)\s*(?<_3>.*)$\n?/,
    name: "meta.header.s5"},
   {begin: /^(?![A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    patterns: 
     [{begin: /(?<_1>^_{10}$)/,
       beginCaptures: {1 => {name: "meta.separator.handout.s5"}},
       comment: 
        "\n\t\t\t\t\t\tname = 'meta.separator.handout.s5';\n\t\t\t\t\t\tmatch = '(^_{10}$)';\n\t\t\t\t\t",
       contentName: "text.html.markdown.handout.s5",
       end: "(?=^(?:(?:✂-{6})+|^\#{10})$)",
       patterns: [{include: "text.html.markdown"}]},
      {begin: /(?<_1>^\#{10}$)/,
       beginCaptures: {1 => {name: "meta.separator.notes.s5"}},
       comment: 
        "\n\t\t\t\t\t\tname = 'meta.separator.notes.s5';\n\t\t\t\t\t\tmatch = '(^\#{10}$)';\n\t\t\t\t\t",
       contentName: "text.html.markdown.notes.s5",
       end: "(?=^(?:(?:✂-{6})+|_{10})$)",
       patterns: [{include: "text.html.markdown"}]},
      {begin: /^(?<_1>(?<_2>✂-{6})+$\n)/,
       beginCaptures: {1 => {name: "meta.separator.slide.s5"}},
       comment: 
        "\n\t\t\t\t\t\tname = 'meta.separator.slide.s5';\n\t\t\t\t\t\tmatch = '^((✂-{6})+$\\n)';\n\t\t\t\t\t",
       contentName: "text.html.markdown.slide.s5",
       end: "(?=^(?:(?:✂-{6})+|_{10}|\#{10})$)",
       patterns: [{include: "text.html.markdown"}]},
      {include: "text.html.markdown"}]}],
 scopeName: "source.s5",
 uuid: "84A2047B-4453-418D-B009-A3D3C60F3D1E"}
