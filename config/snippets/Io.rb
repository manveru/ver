# Encoding: UTF-8

{"ocdo" => 
  {scope: "source.io",
   name: "Object clone do",
   content: "${1:name} := Object clone do(\n\t$0\n)"},
 "ae" => 
  {scope: "source.io",
   name: "assertEquals",
   content: "assertEquals(${1:expected}, ${2:expr})"},
 "ns" => 
  {scope: "source.io",
   name: "newSlot",
   content: 
    "newSlot(\"${1:slotName}\", ${2:defaultValue}, \"${3:docString}\")$0"},
 "ds" => 
  {scope: "source.io",
   name: "docSlot",
   content: "docSlot(\"${1:slotName}\", \"${2:documentation}\")"},
 "ut" => 
  {scope: "source.io",
   name: "UnitTest",
   content: "${1:Something}Test := ${2:UnitTest} clone do(\n\t$0\n)"},
 "cdo" => 
  {scope: "source.io",
   name: "clone do",
   content: "${1:${2:newValue} := ${3:Object} }clone do(\n\t$0\n)"},
 "ts" => 
  {scope: "source.io",
   name: "testMethod",
   content: "test${1:SomeFeature} := method(\n\t$0\n)"},
 "m" => 
  {scope: "source.io",
   name: "method",
   content: "${1:methodName} := method(${2:args,}\n\t$0\n)"},
 "(" => 
  {scope: "source.io",
   name: "Indented Bracketed Line",
   content: "(${1:header,}\n\t${2:body}\n)$0"},
 nil => 
  {scope: 
    "source.io meta.empty-parenthesis.io, source.io meta.comma-parenthesis.io",
   name: "Special: Return Inside Empty Parenthesis",
   content: "\n\t$0\n"}}
