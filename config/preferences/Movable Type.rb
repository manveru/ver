# Encoding: UTF-8

[{name: "Miscellaneous",
  scope: "text.html.mt",
  settings: 
   {decreaseIndentPattern: 
     "(?x)\n\t\t^\\s*\n\t\t(</(?!html)\n\t\t  [A-Za-z0-9]+\\b[^>]*>\n\t\t|-->\n\t\t|\\}\n\t\t)",
    highlightPairs: 
     [["(", ")"], ["{", "}"], ["[", "]"], ["“", "”"], ["<", ">"]],
    increaseIndentPattern: 
     "(?x)\n\t\t(<(?!area|base|br|col|frame|hr|html|img|input|link|meta|param|[^>]*/>)\n\t\t  ([A-Za-z0-9]+)\\b[^>]*>(?!.*</\\2>)\n\t\t|<!--(?!.*-->)\n\t\t|\\{[^}\"']*$\n\t\t)",
    indentNextLinePattern: "<!DOCTYPE(?!.*>)",
    smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["<", ">"],
      ["'", "'"]]},
  uuid: "52B12AFE-F559-40D2-943B-0F70F702B4AC"},
 {name: "Typing Pairs: Empty Tag",
  scope: "text.html.mt invalid.illegal.incomplete",
  settings: 
   {smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["'", "'"],
      ["$", "$"]],
    spellChecking: "0"},
  uuid: "DD648860-34B2-4350-8684-E1C13C54DEEC"},
 {name: "Tag Preferences",
  scope: 
   "text.html.mt entity.name.tag.mt, text.html.mt variable.other.mt, text.html.mt meta.tag",
  settings: {spellChecking: "0"},
  uuid: "23367101-9398-4601-8521-D6C2C6FEBDBE"},
 {name: "Comments",
  scope: "text.html.mt.pure",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "<mt:Ignore>"},
      {name: "TM_COMMENT_END", value: "</mt:Ignore>"},
      {name: "TM_COMMENT_DISABLE_INDENT_2", value: "yes"}]},
  uuid: "34906968-4D08-4AD4-8652-22BC3A5713AA"}]
