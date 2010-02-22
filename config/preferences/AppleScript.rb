# Encoding: UTF-8

[{name: "Indent",
  scope: "source.applescript",
  settings: 
   {decreaseIndentPattern: "(?x)\n\t\t^\\s* (end|else|on\\ error) \\b .*$\n\t",
    increaseIndentPattern: 
     "(?x)\n\t\t^\\s*\n\t\t(\n\t\t tell \\s+ (?! .* \\b(to)\\b) .*\n\t\t|tell\\b.*?\\bto\\ tell \\s+ (?! .* \\b(to)\\b) .*\n\t\t|using\\ terms\\ from\\b.*\n\t\t|if\\b .* \\bthen\\b\n\t\t|else\\b .*\n\t\t|repeat\\b .*\n\t\t|( on | to ) \\b .*\n\t\t|try\n\t\t|with \\s+ timeout\\b .*\n\t\t|ignoring\\b .*\n\t\t)\\s*(--.*?)?$\n\t",
    indentNextLinePattern: "¬$"},
  uuid: "8F2DBD25-3DED-44CE-A902-05DCBC185A99"},
 {name: "Smart Typing Pairs / Highlight Pairs",
  scope: "source.applescript",
  settings: 
   {highlightPairs: 
     [["(", ")"],
      ["\"", "\""],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["«", "»"]],
    smartTypingPairs: [["\"", "\""], ["(", ")"], ["{", "}"], ["«", "»"]]},
  uuid: "1E1529C4-A9D6-43AC-AB48-975F9BFCD7B7"},
 {name: "Completion: Application Name",
  scope: "string.quoted.double.application-name.applescript",
  settings: 
   {completionCommand: "ps -xco command|grep \"^$TM_CURRENT_WORD\"|sort|uniq"},
  uuid: "F4324AFF-97E6-4D2D-B425-B24E99383AA3"},
 {name: "Comments",
  scope: "source.applescript",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "-- "},
      {name: "TM_COMMENT_START_2", value: "(* "},
      {name: "TM_COMMENT_END_2", value: " *)"}]},
  uuid: "C293E159-C4ED-4757-AD60-82E068A13962"}]
