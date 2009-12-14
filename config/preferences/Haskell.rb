# Encoding: UTF-8

[{name: "Indent Patterns",
  scope: "source.haskell",
  settings: 
   {increaseIndentPattern: 
     "((^.*(=|\\bdo|\\bwhere|\\bthen|\\belse|\\bof)\\s*$)|(^.*\\bif(?!.*\\bthen\\b.*\\belse\\b.*).*$))"},
  uuid: "39417FB9-B85C-4213-BB1D-C19BCDD4E487"},
 {name: "Typing Pairs",
  scope: "source.haskell",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["(", ")"],
      ["`", "`"]]},
  uuid: "FBF9D932-D5CE-4EC4-9162-122E511C8627"},
 {name: "Comments",
  scope: "source.haskell",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START_2", value: "{-"},
      {name: "TM_COMMENT_END_2", value: "-}"},
      {name: "TM_COMMENT_START", value: "-- "}]},
  uuid: "E3994307-4D9E-44D6-832E-52C244F1CDF3"},
 {name: "Symbol List",
  scope: "source.haskell entity.name.function.infix",
  settings: {showInSymbolList: "0"},
  uuid: "0C39B945-E2C0-4E43-8A5B-332F6FA73C67"}]
