# Encoding: UTF-8

{"proto" => 
  {scope: "source.js",
   name: "Prototype",
   content: 
    "${1:class_name}.prototype.${2:method_name} = function(${3:first_argument}) {\n\t${0:// body...}\n};\n"},
 "fun" => 
  {scope: "source.js",
   name: "Function",
   content: 
    "function ${1:function_name} (${2:argument}) {\n\t${0:// body...}\n}"},
 "get" => 
  {scope: "source.js",
   name: "Get Elements",
   content: 
    "getElement${1/(T)|.*/(?1:s)/}By${1:T}${1/(T)|(I)|.*/(?1:agName)(?2:d)/}('$2')"},
 "'':f" => 
  {scope: "source.js",
   name: "Object Method String",
   content: 
    "'${1:${2:#thing}:${3:click}}': function(element){\n\t$0\n}${10:,}"},
 ":f" => 
  {scope: "source.js",
   name: "Object Method",
   content: "${1:method_name}: function(${3:attribute}){\n\t$0\n}${10:,}"},
 ":," => 
  {scope: "source.js",
   name: "Object Value JS",
   content: "${1:value_name}:${0:value},"},
 ":" => 
  {scope: "source.js",
   name: "Object key — key: \"value\"",
   content: "${1:key}: ${2:\"${3:value}\"}${4:, }"},
 "for" => 
  {scope: "source.js",
   name: "for (…) {…}",
   content: 
    "for (var ${20:i}=0; ${20:i} < ${1:Things}.length; ${20:i}++) {\n\t${100:${1:Things}[${20:i}]}$0\n};"},
 "f" => 
  {scope: "source.js",
   name: "Anonymous Function",
   content: "function($1) {${0:$TM_SELECTED_TEXT}};"},
 "ife" => 
  {scope: "source.js",
   name: "if … else",
   content: "if (${1:true}) {${0:$TM_SELECTED_TEXT}} else{};"},
 "if" => 
  {scope: "source.js",
   name: "if",
   content: "if (${1:true}) {${0:$TM_SELECTED_TEXT}};"},
 "timeout" => 
  {scope: "source.js",
   name: "setTimeout function",
   content: "setTimeout(function() {$0}${2:}, ${1:10});"}}
