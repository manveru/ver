# Encoding: UTF-8

{"begcap" => 
  {scope: "source.plist.tm-grammar",
   name: "Begin Captures",
   content: "beginCaptures = {\n\t1 = { name = '$1'; };\n};"},
 "cap" => 
  {scope: "source.plist.tm-grammar",
   name: "Captures",
   content: "captures = {\n\t1 = { name = '$1'; };\n};"},
 "com" => 
  {scope: "source.plist.tm-grammar",
   name: "Comment",
   content: "comment = '$0';"},
 "connam" => 
  {scope: "source.plist.tm-grammar",
   name: "Content Name",
   content: "contentName = '$1';"},
 "dis" => 
  {scope: "source.plist.tm-grammar",
   name: "Disable",
   content: "disabled = 1;"},
 "env" => 
  {scope: "source.ruby",
   name: "ENV['TM_…']",
   content: 
    "ENV['TM_${1:S}${1/^(S)|(B)$|.*/(?1:UPPORT_PATH:(?2:UNDLE_SUPPORT))/}']"},
 "endcap" => 
  {scope: "source.plist.tm-grammar",
   name: "End Captures",
   content: "endCaptures = {\n\t1 = { name = '$1'; };\n};"},
 nil => 
  {scope: 
    "source.plist.tm-grammar string.quoted.single, source.plist.tm-grammar string.regexp.oniguruma.single",
   name: "Grammar - Single Quotes",
   content: "''"},
 "inc" => 
  {scope: "source.plist.tm-grammar",
   name: "Rule — Include",
   content: "{\tinclude = '$1'; },"},
 "mat" => 
  {scope: 
    "source.plist.tm-grammar meta.dictionary.repository -meta.value-pair.repository-item",
   name: "Rule — Match (Repository)",
   content: 
    "${1:rule_name} = {\n\tname = '${2:name}';\n\tmatch = '${3:pattern}';\n};"},
 "nam" => 
  {scope: "source.plist.tm-grammar", name: "Name", content: "name = '$1';"},
 "pat" => 
  {scope: "source.plist.tm-grammar",
   name: "Patterns",
   content: "patterns = (\n\t$0\n);"},
 "rep" => 
  {scope: "source.plist.tm-grammar",
   name: "Repository",
   content: "repository = {\n\t${1:rule_name} = {\n\t\t$0\n\t};\n};"},
 "sup" => 
  {scope: "source.ruby",
   name: "Require 'Support/lib/…'",
   content: 
    "require ENV['TM_${1:S}${1/^(S)|(B)$|.*/(?1:UPPORT_PATH:(?2:UNDLE_SUPPORT))/}'] + '/lib/$2'"},
 "beg" => 
  {scope: "source.plist.tm-grammar meta.dictionary.rule",
   name: "Rule — Begin / End (Inside Rule)",
   content: "begin = '$1';\nend = '$2';"}}
