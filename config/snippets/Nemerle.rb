# Encoding: UTF-8

{"try" => 
  {scope: "source.nemerle",
   name: "try ... catch ...  finally",
   content: 
    "try{\n\t$1\n} catch {\n| ${2:name} is ${3:type} => $4\n} finally {\n\t$5\n}\n"},
 "match" => 
  {scope: "source.nemerle",
   name: "match",
   content: "match (${1:value}){\n| ${2:value} => $3\n}"},
 "pub" => {scope: "source.nemerle", name: "public", content: "public "},
 "inter" => 
  {scope: "source.nemerle",
   name: "interface",
   content: "interface ${1:name}{\n\t$2\n}\n"},
 "module" => 
  {scope: "source.nemerle",
   name: "module",
   content: "module ${1:name}{\n\t$2\n}"},
 "vir" => {scope: "source.nemerle", name: "virtual", content: "virtual "},
 "repeat" => 
  {scope: "source.nemerle",
   name: "repeat",
   content: "repeat (${1:times}){\n\t$2\n}"},
 "ove" => {scope: "source.nemerle", name: "override", content: "override "},
 "class" => 
  {scope: "source.nemerle",
   name: "class",
   content: "class ${1:name}{\n\tpublic this(${2:args}){\n\t\t$3\n\t}\n}"},
 "macro" => 
  {scope: "source.nemerle",
   name: "macro",
   content: "macro ${1:name}\n\tsyntax(\"$1\",\"$2\"){\n\t$3\n}"},
 "when" => 
  {scope: "source.nemerle",
   name: "when",
   content: "when (${1:condition}){\n\t$2\n}\n"},
 "sta" => {scope: "source.nemerle", name: "static", content: "static "},
 "Module" => 
  {scope: "source.nemerle",
   name: "module Main",
   content: "module Main{\n\tMain(${1:args}):void{\n\t\t$2\n\t}\n}"},
 "do" => 
  {scope: "source.nemerle",
   name: "do ... while",
   content: "do{\n\t$2\n} while (${1:condition})\n"},
 "pri" => {scope: "source.nemerle", name: "private", content: "private "},
 "fore" => 
  {scope: "source.nemerle",
   name: "foreach",
   content: "foreach (${1:mutable} in ${2:collection}){\n\t$3\n}\n"},
 "abs" => {scope: "source.nemerle", name: "abstract", content: "abstract "},
 "if" => 
  {scope: "source.nemerle",
   name: "if ... else",
   content: "if (${1:condition}){\n\t$2\n} else {\n\t$3\n}"},
 "variant" => 
  {scope: "source.nemerle",
   name: "variant",
   content: "variant ${1:name}{\n\t| $2\n}"},
 "sea" => {scope: "source.nemerle", name: "sealed", content: "sealed "},
 "for" => 
  {scope: "source.nemerle",
   name: "for",
   content: 
    "for (mutable ${1:name}=${2:value}; ${3:condition}; $1++){\n\t$4\n}"},
 "mu" => 
  {scope: "source.nemerle", name: "mutable", content: "mutable ${1:name}"},
 "while" => 
  {scope: "source.nemerle",
   name: "while",
   content: "while (${1:condition}){\n\t$2\n}"},
 "unless" => 
  {scope: "source.nemerle",
   name: "unless",
   content: "unless (${1:condition}){\n\t$2\n}"},
 "enum" => 
  {scope: "source.nemerle",
   name: "enum",
   content: "enum ${1:name}{\n\t| $2\n}"}}
