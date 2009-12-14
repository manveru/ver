# Encoding: UTF-8

[{name: "Indentation",
  scope: "source.slate",
  settings: 
   {decreaseIndentPattern: "^\\s*(\\]|\\}|\\))$",
    highlightPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["|", "|"],
      ["[", "]"],
      ["“", "”"],
      ["'", "'"]],
    increaseIndentPattern: "^.*(\\(|\\[|\\{].*[^)]}\"]$",
    shellVariables: 
     [{name: "TM_COMMENT_START", value: "\""},
      {name: "TM_COMMENT_END", value: "\""}]},
  uuid: "DCF79A2D-917F-4528-BC5F-4ACDF9891AB6"},
 {name: "Typing Pairs Default",
  scope: "source.slate",
  settings: 
   {smartTypingPairs: 
     [["'", "'"], ["\"", "\""], ["(", ")"], ["{", "}"], ["[", "]"]]},
  uuid: "8B7EC0F3-2EFD-438E-AA61-0B2E9F5347FA"},
 {name: "Typing Pairs in Blocks",
  scope: "source.slate meta.block.header.slate",
  settings: 
   {smartTypingPairs: 
     [["'", "'"],
      ["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["|", "|"]]},
  uuid: "C41BA7AC-7461-4109-A8F7-EA0D01E34616"}]
