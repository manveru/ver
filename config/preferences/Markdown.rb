# Encoding: UTF-8

[{name: "Spell Checking: Disable",
  scope: "text.html.markdown meta.reference, meta.link.markdown entity.name",
  settings: {spellChecking: "0"},
  uuid: "C2DBC2F2-D859-4B35-A38E-244927A8447F"},
 {name: "Indent: Raw Block",
  scope: "markup.raw.block.markdown",
  settings: 
   {decreaseIndentPattern: "^(.*\\*/)?\\s*\\}[;\\s]*$",
    increaseIndentPattern: "^.*(\\{[^}\"']*|\\([^)\"']*)$"},
  uuid: "E23C5DD2-9A36-4B4A-9729-2A769A055B92"},
 {name: "Typing Pairs: Defaults",
  scope: "text.html.markdown",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["`", "`"],
      ["_", "_"],
      ["<", ">"]]},
  uuid: "15E0B3D5-8523-40EF-B767-5AF153FFD11E"},
 {name: "Typing Pairs: Disable _ for Raw and Links",
  scope: "text.html.markdown markup.raw, text.html.markdown meta.link",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["`", "`"]]},
  uuid: "146B2643-D903-49A8-9586-BE9C509D65B1"},
 {name: "Symbol List: Heading",
  scope: "text.html.markdown markup.heading.markdown",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/\\s*#*\\s*\\z//g;\t\t\t# strip trailing space and #'s\n\t\ts/(?<=#)#/ /g;\t\t\t# change all but first # to m-space\n\t\ts/^#( *)\\s+(.*)/$1$2/;\t\t# strip first # and space before title\n\t"},
  uuid: "C02A37C1-E770-472F-A13E-358FF0C6AD89"}]
