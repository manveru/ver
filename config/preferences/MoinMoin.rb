# Encoding: UTF-8

[{name: "Spell Checking: Disable",
  scope: 
   "text.moinmoin markup.raw, meta.macro.moimoin, meta.pragma.moimoin, comment.line.moinmoin",
  settings: {spellChecking: "0"},
  uuid: "B55CE47F-D621-4D84-8C56-61FFDDD7E710"},
 {name: "Symbol List",
  scope: "text.moinmoin markup.heading",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/\\s*=*[^=]*$//; # remove trailing space, =\n\t\ts/^\\s*//;  # remove leading space\n\t\ts/\\G=/ /g; # convert leading = to m-space\n\t\ts/^ //;    # strip first m-space\n\t"},
  uuid: "62CBBA22-7680-4213-A3CC-707336A65F5A"},
 {name: "Typing Pairs: Defaults",
  scope: "text.moinmoin",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["`", "`"]]},
  uuid: "ECAD7950-590C-4D8F-B17A-BF64DD5975A3"}]
