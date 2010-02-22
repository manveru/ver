# Encoding: UTF-8

[{name: "Miscellaneous",
  scope: "source.active4d",
  settings: 
   {decreaseIndentPattern: 
     "^\\s*((?i:end\\ (if|while|for\\ each|for|case|method)|until|else)\\b|%>)",
    highlightPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["'", "'"],
      ["`", "`"]],
    increaseIndentPattern: 
     "^\\s*((?i:if|while|for\\ each|for|case\\ of|repeat|method|else)\\b|<%|:\\()",
    smartTypingPairs: 
     [["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["'", "'"],
      ["`", "`"]]},
  uuid: "22573B7E-1CE8-41CA-BFB5-32B01CA52D5F"},
 {name: "Comments",
  scope: "source.active4d",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "// "},
      {name: "TM_COMMENT_MODE", value: "line"}]},
  uuid: "942A77CF-CBDC-46BE-9C9C-CA475F60B97A"},
 {name: "Symbol List: Method",
  scope: "entity.name.function.active4d",
  settings: {showInSymbolList: 1, symbolTransformation: "s/\"(.+?)\"/$1/"},
  uuid: "9F07A325-1520-4386-890D-A14C62555121"}]
