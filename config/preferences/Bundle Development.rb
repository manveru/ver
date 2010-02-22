# Encoding: UTF-8

[{name: "Symbol List (Repository Separator)",
  scope: "support.constant.repository.tm-grammar",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/^repository$/-/;\t\t\t\t# repository = separator\n\t"},
  uuid: "1515233D-64A7-48B3-A032-895A2A2E9789"},
 {name: "Symbol List (Repository Item Scopes)",
  scope: 
   "source.plist.tm-grammar meta.value-pair.repository-item constant.other.scope - meta.dictionary.captures",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/^(punctuation.*$)?/    /;\n\t"},
  uuid: "46D63D96-FBDA-4E36-B088-018D6B672FFB"},
 {name: "Symbol List",
  scope: 
   "source.plist.tm-grammar constant.other.scope - (meta.dictionary.repository|meta.value-pair.scopename)",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/^punctuation.*$//;\n\t"},
  uuid: "985E70CD-0539-4E00-B0B9-F38D9789B8F3"},
 {name: "Symbol List (Repository Items)",
  scope: 
   "meta.dictionary.repository.tm-grammar entity.name.section.repository.tm-grammar",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/^/#/;\t\t\t\t# start with \"#\"\n\t"},
  uuid: "6F3A4873-C006-471C-BC7E-7EF289C685B4"}]
