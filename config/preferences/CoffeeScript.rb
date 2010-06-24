# Encoding: UTF-8

[{name: "Comments",
  scope: "source.coffee",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "# "},
      {name: "TM_COMMENT_START_2", value: "###"},
      {name: "TM_COMMENT_END_2", value: "###"}]},
  uuid: "0A92C6F6-4D73-4859-B38C-4CC19CBC191F"},
 {name: "Indent",
  scope: "source.coffee",
  settings: 
   {decreaseIndentPattern: "^\\s*(\\}|\\])$",
    increaseIndentPattern: 
     "(?x)\n\t\t^\\s*\n\t\t(.*class\n\t\t|[a-zA-Z\\$_](\\w|\\$|:|\\.)*\\s*(?=\\:(\\s*\\(.*\\))?\\s*((=|-)>\\s*$)) # function that is not one line\n\t\t|[a-zA-Z\\$_](\\w|\\$|\\.)*\\s*(?=(?!\\::)\\:(?!(\\s*\\(.*\\))?\\s*((=|-)>))):\\s*((if|while)(?!.*?then)|for|$) # assignment using multiline if/while/for\n\t\t|(if|while)(?!.*?then)|for\n\t\t|.*\\{$\n\t\t|.*\\[$)"},
  uuid: "C5D6C716-12FE-4CE8-A916-6CABEDE8AFE7"},
 {name: "Symbol List: Method",
  scope: "source.coffee meta.function",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "s/^(\\s*)([a-zA-Z\\$_](\\w|\\$|:|\\.))*\\s*:/$1$2/"},
  uuid: "419D24D8-0DD6-4D9A-8CA0-6D9CD740BEEC"},
 {name: "Symbol List: Method Instance",
  scope: "source.coffee entity.name.type.instance",
  settings: {showInSymbolList: 0},
  uuid: "B087AF2F-8946-4EA9-8409-49E7C4A2EEF0"}]
