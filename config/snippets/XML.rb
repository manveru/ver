# Encoding: UTF-8

{nil => 
  {scope: "meta.scope.between-tag-pair.xml",
   name: "Special: Return Inside Empty Open/Close Tags",
   content: "\n\t$0\n"},
 "<a" => 
  {scope: "text.xml",
   name: "Long Attribute Tag",
   content: "<${1:name} ${2:attr=\"value\"}>$0\n</${1:name}>"},
 "<" => 
  {scope: "text.xml",
   name: "Long Tag",
   content: "<${1:name}>$0</${1/([^ ]+).*/$1/}>"},
 ">" => {scope: "text.xml", name: "Short Tag", content: "<${1:name} />"},
 "cdata" => {scope: "text.xml", name: "CDATA", content: "<![CDATA[$0]]>"},
 "xml" => 
  {scope: "text.xml",
   name: "XML Processing Instruction",
   content: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"}}
