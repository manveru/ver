# Encoding: UTF-8

{nil => 
  {scope: "source.java, source.groovy",
   name: "New Doc Block",
   content: "/**\n * $0\n */"},
 "a" => 
  {scope: "comment.block.documentation.javadoc",
   name: "author",
   content: "@author ${0:$TM_FULLNAME}"},
 "{" => 
  {scope: "comment.block.documentation.javadoc",
   name: "value",
   content: "{@value $0"},
 "d" => 
  {scope: "comment.block.documentation.javadoc",
   name: "deprecated",
   content: "@deprecated ${0:description}"},
 "null" => 
  {scope: "comment.block.documentation.javadoc",
   name: "null",
   content: "{@code null}"},
 "p" => 
  {scope: "comment.block.documentation.javadoc",
   name: "param",
   content: "@param ${1:var} ${0:description}"},
 "r" => 
  {scope: "comment.block.documentation.javadoc",
   name: "return",
   content: "@return ${0:description}"},
 "s" => 
  {scope: "comment.block.documentation.javadoc",
   name: "see",
   content: "@see ${0:reference}"},
 "se" => 
  {scope: "comment.block.documentation.javadoc",
   name: "serial",
   content: "@serial ${0:description}"},
 "sd" => 
  {scope: "comment.block.documentation.javadoc",
   name: "serialData",
   content: "@serialField ${0:description}"},
 "sf" => 
  {scope: "comment.block.documentation.javadoc",
   name: "serialField",
   content: "@serialField ${1:name} ${2:type} ${0:description}"},
 "si" => 
  {scope: "comment.block.documentation.javadoc",
   name: "since",
   content: "@since ${0:version}"},
 "t" => 
  {scope: "comment.block.documentation.javadoc",
   name: "throws",
   content: "@throws ${1:class} ${0:description}"},
 "v" => 
  {scope: "comment.block.documentation.javadoc",
   name: "version",
   content: "@version ${0:version}"}}
