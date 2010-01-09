# Encoding: UTF-8

{"red" => 
  {scope: "text.html.mediawiki",
   name: "#REDIRECT [[…]]",
   content: "#REDIRECT [[${1:Main Page}]]"},
 nil => 
  {scope: "text.html.mediawiki markup.list",
   name: "New List Item",
   content: "\n${TM_CURRENT_LINE/^([:;#* ]*).*/$1/}"},
 "ref" => 
  {scope: "text.html.mediawiki",
   name: "Reference {{Fact|date=month yyyy}}",
   content: "{{Fact|date=`date \"+%B %Y\"`}} "}}
