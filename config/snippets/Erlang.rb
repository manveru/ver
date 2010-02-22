# Encoding: UTF-8

{"ifndef" => 
  {scope: "source.erlang",
   name: "Ifndef Directive",
   content: "-ifndef (${1:macro})."},
 "imp" => 
  {scope: "source.erlang",
   name: "Import Directive",
   content: "-import (${1:module}, [${2:function}/${3:arity}])."},
 nil => 
  {scope: "source.erlang",
   name: "(Function Clause)",
   content: "${1:function} (${2:param})${3: when ${4:guard}} ->\n\t${5:body}"},
 "inc" => 
  {scope: "source.erlang",
   name: "Include Directive",
   content: "-include (\"${1:file}\")."},
 "mod" => 
  {scope: "source.erlang",
   name: "Module Directive",
   content: "-module (${1:${TM_FILEPATH/^.*\\/(.*)\\.erl$/$1/g}})."},
 "if" => 
  {scope: "source.erlang",
   name: "If Expression",
   content: "if\n\t${1:guard} ->\n\t\t${2:body}\nend"},
 "ifdef" => 
  {scope: "source.erlang",
   name: "Ifdef Directive",
   content: "-ifdef (${1:macro})."},
 "undef" => 
  {scope: "source.erlang",
   name: "Undef Directive",
   content: "-undef (${1:macro})."},
 "rec" => 
  {scope: "source.erlang",
   name: "Record Directive",
   content: "-record (${1:record}, {${2:field}${3: = ${4:value}}})."},
 "def" => 
  {scope: "source.erlang",
   name: "Define Directive",
   content: "-define (${1:macro}${2: (${3:param})}, ${4:body})."},
 "rcv" => 
  {scope: "source.erlang",
   name: "Receive Expression",
   content: 
    "receive\n${1:\t${2:pattern}${3: when ${4:guard}} ->\n\t\t${5:body}\n}${6:after\n\t${7:expression} ->\n\t\t${8:body}\n}end"},
 "fun" => 
  {scope: "source.erlang",
   name: "Fun Expression",
   content: 
    "fun\n\t(${1:pattern})${2: when ${3:guard}} ->\n\t\t${4:body}\nend"},
 "beh" => 
  {scope: "source.erlang",
   name: "Behaviour Directive",
   content: "-behaviour (${1:behaviour})."},
 "exp" => 
  {scope: "source.erlang",
   name: "Export Directive",
   content: "-export ([${1:function}/${2:arity}])."},
 "case" => 
  {scope: "source.erlang",
   name: "Case Expression",
   content: 
    "case ${1:expression} of\n\t${2:pattern}${3: when ${4:guard}} ->\n\t\t${5:body}\nend"},
 "try" => 
  {scope: "source.erlang",
   name: "Try Expression",
   content: 
    "try${1: ${2:expression}${3: of\n\t${4:pattern}${5: when ${6:guard}} ->\n\t\t${7:body}}}\n${8:catch\n\t${9:pattern}${10: when ${11:guard}} ->\n\t\t${12:body}}\n${13:after\n\t${14:body}}\nend"}}
