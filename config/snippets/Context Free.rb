# Encoding: UTF-8

{"s" => 
  {scope: "source.context-free",
   name: "Startshape Directive",
   content: "startshape ${1:shape}"},
 "i" => 
  {scope: "source.context-free",
   name: "Include Directive",
   content: "include ${1:${2:file}.cfdg}"},
 "r" => 
  {scope: "source.context-free",
   name: "Rule",
   content: "rule ${1:shape} ${2:weight }{\n\t$3\n}"},
 "T" => 
  {scope: "source.context-free",
   name: "Triangle Primitive",
   content: "TRIANGLE {$1}"},
 "b" => 
  {scope: "source.context-free",
   name: "Background Directive",
   content: "background {$1}"},
 "S" => 
  {scope: "source.context-free",
   name: "Square Primitive",
   content: "SQUARE {$1}"},
 "C" => 
  {scope: "source.context-free",
   name: "Circle Primitive",
   content: "CIRCLE {$1}"}}
