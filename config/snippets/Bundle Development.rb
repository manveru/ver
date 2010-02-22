# Encoding: UTF-8

{"beg" => 
  {scope: "source.plist.tm-grammar meta.array.patterns",
   name: "Rule — Begin / End",
   content: "{\tname = '${1:name}';\n\tbegin = '$2';\n\tend = '$3';\n},"},
 "sup" => 
  {scope: "source.ruby",
   name: "Require 'Support/lib/…'",
   content: 
    "require ENV['TM_${1:S}${1/^(S)|(B)$|.*/(?1:UPPORT_PATH:(?2:UNDLE_SUPPORT))/}'] + '/lib/$2'"},
 "rep" => 
  {scope: "source.plist.tm-grammar",
   name: "Repository",
   content: "repository = {\n\t${1:rule_name} = {\n\t\t$0\n\t};\n};"},
 nil => 
  {scope: 
    "source.plist.tm-grammar string.quoted.single, source.plist.tm-grammar string.regexp.oniguruma.single",
   name: "Grammar - Single Quotes",
   content: "''"},
 "endcap" => 
  {scope: "source.plist.tm-grammar",
   name: "End Captures",
   content: "endCaptures = {\n\t1 = { name = '$1'; };\n};"},
 "mat" => 
  {scope: "source.plist.tm-grammar meta.dictionary.rule",
   name: "Rule — Match (Inside Rule)",
   content: "match = '${1:pattern}';"},
 "begcap" => 
  {scope: "source.plist.tm-grammar",
   name: "Begin Captures",
   content: "beginCaptures = {\n\t1 = { name = '$1'; };\n};"},
 "env" => 
  {scope: "source.ruby",
   name: "ENV['TM_…']",
   content: 
    "ENV['TM_${1:S}${1/^(S)|(B)$|.*/(?1:UPPORT_PATH:(?2:UNDLE_SUPPORT))/}']"},
 "inc" => 
  {scope: "source.plist.tm-grammar",
   name: "Rule — Include",
   content: "{\tinclude = '$1'; },"},
 "connam" => 
  {scope: "source.plist.tm-grammar",
   name: "Content Name",
   content: "contentName = '$1';"},
 "cap" => 
  {scope: "source.plist.tm-grammar",
   name: "Captures",
   content: "captures = {\n\t1 = { name = '$1'; };\n};"},
 "dis" => 
  {scope: "source.plist.tm-grammar",
   name: "Disable",
   content: "disabled = 1;"},
 "pat" => 
  {scope: "source.plist.tm-grammar",
   name: "Patterns",
   content: "patterns = (\n\t$0\n);"},
 "nam" => 
  {scope: "source.plist.tm-grammar", name: "Name", content: "name = '$1';"},
 "com" => 
  {scope: "source.plist.tm-grammar",
   name: "Comment",
   content: "comment = '$0';"}}
