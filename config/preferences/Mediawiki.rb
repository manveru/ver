# Encoding: UTF-8

[{name: "Symbol List",
  scope: "text.html.mediawiki markup.heading.mediawiki",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/\\s*=*\\s*$//;\t\t\t\t# strip trailing space and #'s\n\t\ts/(?<==)=/ /g;\t\t\t# change all but first # to m-space\n\t\ts/^=( *)\\s+(.*)/$1$2/;\t\t# strip first # and space before title\n\t"},
  uuid: "5FB06962-01CA-4D3D-8DC7-B6C6996F6111"},
 {name: "Typing Pairs",
  scope: "text.html.mediawiki",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["=", "="]]},
  uuid: "9991014D-6D8B-4C8A-BCF6-0A3CB9C8E4C9"},
 {name: "Typing Pairs (outside heading)",
  scope: 
   "text.html.mediawiki meta, text.html.mediawiki markup - markup.heading.mediawiki",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""], ["(", ")"], ["{", "}"], ["[", "]"], ["“", "”"]]},
  uuid: "F8F06C9F-E761-46CD-867A-14865AA0915B"}]
