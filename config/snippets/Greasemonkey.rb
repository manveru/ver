# Encoding: UTF-8

{"e" => 
  {scope: "source.js.greasemonkey meta.header",
   name: "@exclude",
   content: "// @exclude       ${1:http://}$0"},
 "i" => 
  {scope: "source.js.greasemonkey meta.header",
   name: "@include",
   content: "// @include       ${1:http://}$0"},
 "css" => 
  {scope: "source.js.greasemonkey",
   name: "GM_addStyle",
   content: "GM_addStyle(\"${1:CSS}\");"},
 "get" => 
  {scope: "source.js.greasemonkey",
   name: "GM_getValue",
   content: "GM_getValue(\"${1:key}\", ${2:\"${3:default value}\"});"},
 "log" => 
  {scope: "source.js.greasemonkey",
   name: "GM_log",
   content: "GM_log(${1:\"${2:info}\"});"},
 "tab" => 
  {scope: "source.js.greasemonkey",
   name: "GM_openInTab",
   content: "GM_openInTab(${1:\"${2:http://www.example.com}\"});\n$0"},
 "menu" => 
  {scope: "source.js.greasemonkey",
   name: "GM_registerMenuCommand",
   content: 
    "GM_registerMenuCommand(\"${1:Command Name}\", ${3:function() {\n\t$0\n\\}});"},
 "set" => 
  {scope: "source.js.greasemonkey",
   name: "GM_setValue",
   content: "GM_setValue(\"${1:key}\", ${2:\"${3:value}\"});"},
 "xhr" => 
  {scope: "source.js.greasemonkey",
   name: "GM_xmlhttpRequest",
   content: 
    "GM_xmlhttpRequest({\n\tmethod: \"GET\",\n\turl: ${1:\"${2:http://www.example.com}\"},\n\tonload: ${3:function(result) {\n\t\t${0:var response = result.responseText;}\n\t\\} }\n});"},
 "clog" => 
  {scope: "source.js.greasemonkey",
   name: "console.log",
   content: "console.log(\"${1:Debug: %o}\", ${2:object});"}}
