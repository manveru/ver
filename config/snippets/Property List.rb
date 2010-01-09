# Encoding: UTF-8

{"array" => 
  {scope: "text.xml.plist", name: "array", content: "<array>\n\t$0\n</array>"},
 "data" => 
  {scope: "text.xml.plist", name: "data", content: "<data>\n\t$1\n</data>"},
 "date" => 
  {scope: "text.xml.plist",
   name: "date",
   content: 
    "<date>${1:YYYY}${2/.+/-/}${2:MM}${3/.+/-/}${3:DD}${4/.+/T/}${4:hh}${5/.+/:/}${5:mm}${6/.+/:/}${6:ss}${4/.+/Z/}</date>"},
 "dict" => 
  {scope: "text.xml.plist", name: "dict", content: "<dict>\n\t$0\n</dict>"},
 "f" => {scope: "text.xml.plist", name: "false", content: "<false/>"},
 "int" => 
  {scope: "text.xml.plist", name: "integer", content: "<integer>$1</integer>"},
 "key" => {scope: "text.xml.plist", name: "key", content: "<key>$1</key>"},
 "plist" => 
  {scope: "text.xml.plist",
   name: "plist",
   content: 
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n$0\n</plist>"},
 "real" => {scope: "text.xml.plist", name: "real", content: "<real>$1</real>"},
 "str" => 
  {scope: "text.xml.plist", name: "string", content: "<string>$1</string>"},
 "t" => {scope: "text.xml.plist", name: "true", content: "<true/>"}}
