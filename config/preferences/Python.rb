# Encoding: UTF-8

[{name: "Miscellaneous",
  scope: "source.python",
  settings: 
   {decreaseIndentPattern: "^\\s*(elif|else|except|finally)\\b.*:",
    increaseIndentPattern: 
     "^\\s*(class|def|elif|else|except|finally|for|if|try|with|while)\\b.*:\\s*$",
    shellVariables: 
     [{name: "TM_COMMENT_START", value: "# "},
      {name: "TM_LINE_TERMINATOR", value: ":"}]},
  uuid: "33877934-69D3-4773-8786-9B5211012A9A"},
 {name: "Symbol List",
  scope: "source.python meta.function.python, source.python meta.class.python",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/class\\s+([A-Za-z_][A-Za-z0-9_]*.+?\\)?)(\\:|$)/$1/g;\n\t\ts/def\\s+([A-Za-z_][A-Za-z0-9_]*\\()(?:(.{,40}?\\))|((.{40}).+?\\)))(\\:)/$1(?2:$2)(?3:$4…\\))/g;\n\t"},
  uuid: "005BE156-8D74-4036-AF38-283708645115"},
 {name: "Symbol List: Hide Decorator",
  scope: 
   "source.python meta.function.decorator.python entity.name.function.decorator.python",
  settings: {showInSymbolList: 0},
  uuid: "F5CE4B1B-6167-4693-A49B-021D97C18F5A"}]
