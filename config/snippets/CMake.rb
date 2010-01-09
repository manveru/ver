# Encoding: UTF-8

{"glob" => 
  {scope: "source.cmake",
   name: "File(Glob …)",
   content: "FILE(GLOB${1:_RECURSE} ${2:VAR} ${3:src/*.cc})"},
 "for" => 
  {scope: "source.cmake",
   name: "Foreach … EndForeach",
   content: "FOREACH(${1:VAR} ${2:items})\n\t$0\nENDFOREACH()"},
 "fun" => 
  {scope: "source.cmake",
   name: "Function … EndFunction",
   content: 
    "FUNCTION(${1:FUNCTION_NAME}${2/(.+)/(?1: )/}${2:arg1})\n\t$0\nENDFUNCTION()"},
 "if" => 
  {scope: "source.cmake",
   name: "If … Endif",
   content: "IF(${1:condition})\n\t$0\nENDIF()"},
 "append" => 
  {scope: "source.cmake",
   name: "List(Append …)",
   content: "LIST(APPEND ${1:LIST_VARIABLE} ${2:new_element})"},
 "mac" => 
  {scope: "source.cmake",
   name: "Macro … EndMacro",
   content: 
    "MACRO(${1:MACRO_NAME}${2/(.+)/(?1: )/}${2:arg1})\n\t$0\nENDMACRO()"},
 "msg" => 
  {scope: "source.cmake", name: "Message(…)", content: "MESSAGE(\"$1\")$0"},
 "set" => 
  {scope: "source.cmake",
   name: "Set(Variable …)",
   content: "SET(${1:VAR} ${2:value})"}}
