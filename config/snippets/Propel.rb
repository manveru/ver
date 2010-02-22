# Encoding: UTF-8

{"<t" => 
  {scope: "text.xml",
   name: "xml - table",
   content: 
    "<table name=\"${1:name}\"${2: phpName=\"${3:php_name}\"}>\n\t$0\n</table>"},
 "<u" => 
  {scope: "text.xml",
   name: "xml - unique",
   content: 
    "<unique name=\"unique_${1:key}\">\n\t<unique-column name=\"${1:key}\" />\n</unique>"},
 "<f" => 
  {scope: "text.xml",
   name: "xml - foreign key",
   content: 
    "<foreign-key foreignTable=\"${1:table}\">\n\t<reference local=\"${1:table}_id\" foreign=\"${2:id}\"/>\n</foreign-key>"},
 "<p" => 
  {scope: "text.xml",
   name: "xml - primary key",
   content: 
    "<column name=\"${1:id}\" type=\"${2:integer}\" required=\"true\" primaryKey=\"true\" autoincrement=\"true\" />"},
 "<c" => 
  {scope: "text.xml",
   name: "xml - column",
   content: 
    "<column name=\"${1:name}\" type=\"${2:type}\"${3: required=\"${4:true}\"}${5: default=\"${6:}\"} />"},
 "<i" => 
  {scope: "text.xml",
   name: "xml - index",
   content: 
    "<index name=\"${1:key}_index\">\n\t<index-column name=\"${1:key}\" />\n</index>"}}
