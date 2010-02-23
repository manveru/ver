# Encoding: UTF-8

[{name: "Comments",
  scope: "source.erlang",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "% "},
      {name: "TM_COMMENT_MODE", value: "line"}]},
  uuid: "08AFD8DA-AEFF-4979-98BA-21D5B0A59D33"},
 {name: "Function Symbols",
  scope: "source.erlang entity.name.function.definition",
  settings: {showInSymbolList: 1, symbolTransformation: "s,$,/,"},
  uuid: "7D7FE91B-0543-4F95-8D99-AF393226415C"},
 {name: "Indentation Rules",
  scope: "source.erlang",
  settings: 
   {decreaseIndentPattern: "^\\s*\\b(end)\\b",
    increaseIndentPattern: 
     "^[^%]*(\\b(if|case|receive|after|fun|try|catch|begin|query)\\b(?!.*\\b(end)\\b.*))|(->(\\s*%.*)?$)"},
  uuid: "34E0D602-ADAE-43F9-A661-0323A821AB75"},
 {name: "Macro Symbols",
  scope: "source.erlang entity.name.function.macro.definition",
  settings: {showInSymbolList: 1, symbolTransformation: "s/^/?/"},
  uuid: "5EEC72E3-EEA9-4C53-8D70-3903EF1D84E2"},
 {name: "Module Symbols",
  scope: "source.erlang entity.name.type.class.module.definition.erlang",
  settings: {showInSymbolList: 1, symbolTransformation: "s/^/-/"},
  uuid: "1250456F-9F83-4BAA-B338-5C9E86E89DD9"},
 {name: "Record Symbols",
  scope: "source.erlang entity.name.type.class.record.definition",
  settings: {showInSymbolList: 1, symbolTransformation: "s/^/#/"},
  uuid: "31DB728C-AC89-4DF0-A2B9-9D3D3A7552A9"},
 {name: "Symbol Overrides",
  scope: 
   "source.erlang entity.name.function, source.erlang entity.name.type.class",
  settings: {showInSymbolList: "0"},
  uuid: "AE84FFDF-2D5A-4331-A301-6CF34CF26CD8"}]
