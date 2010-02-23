# Encoding: UTF-8

[{content: 
   "<column name=\"${1:name}\" type=\"${2:type}\"${3: required=\"${4:true}\"}${5: default=\"${6:}\"} />",
  name: "xml - column",
  scope: "text.xml",
  tabTrigger: "<c",
  uuid: "8A4ECDB9-F980-4CDE-B098-1ADA7B3C1928"},
 {content: 
   "<foreign-key foreignTable=\"${1:table}\">\n\t<reference local=\"${1:table}_id\" foreign=\"${2:id}\"/>\n</foreign-key>",
  name: "xml - foreign key",
  scope: "text.xml",
  tabTrigger: "<f",
  uuid: "961E053E-5A74-4959-A303-D3B6A4FC247C"},
 {content: 
   "<index name=\"${1:key}_index\">\n\t<index-column name=\"${1:key}\" />\n</index>",
  name: "xml - index",
  scope: "text.xml",
  tabTrigger: "<i",
  uuid: "09EF9AD8-F6B8-4C66-BBD0-F8E1CC6AC97F"},
 {content: 
   "<column name=\"${1:id}\" type=\"${2:integer}\" required=\"true\" primaryKey=\"true\" autoincrement=\"true\" />",
  name: "xml - primary key",
  scope: "text.xml",
  tabTrigger: "<p",
  uuid: "251F74BF-A606-4F1E-847F-EAB5CFF99954"},
 {content: 
   "<table name=\"${1:name}\"${2: phpName=\"${3:php_name}\"}>\n\t$0\n</table>",
  name: "xml - table",
  scope: "text.xml",
  tabTrigger: "<t",
  uuid: "BCE8C7F8-DFE0-4AEC-916C-E7541F2AC677"},
 {content: 
   "<unique name=\"unique_${1:key}\">\n\t<unique-column name=\"${1:key}\" />\n</unique>",
  name: "xml - unique",
  scope: "text.xml",
  tabTrigger: "<u",
  uuid: "2340D768-1E9F-455C-AC2E-1F1570A1424F"}]
