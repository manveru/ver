# Encoding: UTF-8

[{name: "Symbol List: Classes",
  scope: "source.groovy entity.name.type.class",
  settings: {showInSymbolList: 1},
  uuid: "6201F313-C9FB-4D7E-9D01-FB85287BE21C"},
 {name: "Symbol List: Variables",
  scope: "source.groovy meta.definition.class-variable.name",
  settings: {showInSymbolList: 1, symbolTransformation: "\n\t\ts/.+/$0/g\n\t"},
  uuid: "CF622434-558B-4333-8B57-76576354D6DC"},
 {name: "Symbol List: Class Variables",
  scope: 
   "source.groovy meta.definition.class meta.definition.class-variable.name",
  settings: 
   {showInSymbolList: 1, symbolTransformation: "\n\t\ts/.+/  $0/g\n\t"},
  uuid: "AAC3FB7F-5428-4B6A-B43E-62E4C6677E1F"},
 {name: "Symbol List: Class Methods",
  scope: 
   "source.groovy meta.definition.class meta.definition.method.signature",
  settings: 
   {showInSymbolList: 1, symbolTransformation: "\n\t\ts/.+/  $0/g\n\t"},
  uuid: "C0E2BE5E-3DB3-4F86-AB3D-5800E4307C29"},
 {name: "Symbol List: Methods",
  scope: "source.groovy meta.definition.method.signature",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/\\s*.*\\s+(\\w+)\\s*(\\(.*\\)).*/    $1$2/g\n\t"},
  uuid: "6AF1B177-1700-478F-808B-78D85403FC19"}]
