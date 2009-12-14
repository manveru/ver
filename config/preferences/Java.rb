# Encoding: UTF-8

[{name: "Symbol List: Methods",
  scope: "source.java meta.class.body meta.method.identifier",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/\\s{2,}/ /g;\n\t\ts/.*/  $0/g;\n\t"},
  uuid: "FA4CD3FA-A79B-43E3-A432-DA53DA4A060D"},
 {name: "Comments",
  scope: "source.java",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "// "},
      {name: "TM_COMMENT_START_2", value: "/*"},
      {name: "TM_COMMENT_END_2", value: "*/"}]},
  uuid: "FBA964F9-EA31-44D1-A5FD-AE8AB3FF8954"},
 {name: "Indentation Rules",
  scope: "source.java",
  settings: 
   {decreaseIndentPattern: 
     "^(.*\\*/)?\\s*\\}([^}{\"']*\\{)?[;\\s]*(//.*|/\\*.*\\*/\\s*)?$|^\\s*(public|private|protected):\\s*$",
    increaseIndentPattern: 
     "^.*\\{[^}\"']*$|^\\s*(public|private|protected):\\s*$",
    indentNextLinePattern: 
     "^(?!(.*[};:])?\\s*(//|/\\*.*\\*/\\s*$)).*[^\\s;:{}]\\s*$"},
  uuid: "20E93106-18CF-4BA3-9DA3-8F0C955DB774"},
 {name: "Symbol List: Classes",
  scope: "source.java meta.class meta.class.identifier",
  settings: {showInSymbolList: 1},
  uuid: "22E489AE-989E-4A76-9C18-89944CF5013D"},
 {name: "Symbol List: Inner Class Methods",
  scope: "source.java meta.class.body meta.class.body meta.method.identifier",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/\\s{2,}/ /g;\n\t\ts/.*/    $0/g;\n\t"},
  uuid: "11D7DA6F-1AE7-4BC7-BB5E-8DF05984FEEE"},
 {name: "Symbol List: Inner Classes",
  scope: "source.java meta.class.body meta.class.identifier",
  settings: {showInSymbolList: 1, symbolTransformation: "s/.*/  $0/g"},
  uuid: "7A55A2BC-CD9D-4EBF-ABF4-3401AA64B7B3"},
 {name: "Symbol List: Inner Inner Class Methods",
  scope: 
   "source.java meta.class.body meta.class.body meta.class.body meta.method.identifier",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/\\s{2,}/ /g;\n\t\ts/.*/    $0/g;\n\t"},
  uuid: "FD0CE2DC-6D44-4E22-B4E5-C47C57F5B677"},
 {name: "Symbol List: Inner Inner Classes",
  scope: "source.java meta.class.body meta.class.body meta.class.identifier",
  settings: {showInSymbolList: 1, symbolTransformation: "s/.*/    $0/g"},
  uuid: "C80430E0-F37F-448F-ACAE-D590C96C4EAD"}]
