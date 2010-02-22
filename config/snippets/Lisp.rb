# Encoding: UTF-8

{"(" => {scope: "source.lisp", name: "`(", content: "\\`("},
 "par" => 
  {scope: "source.lisp",
   name: "defparameter",
   content: 
    "(defparameter *${1:name}* ${2:value}\n\t\"${3:Documentation for $1.}\")"},
 "fun" => 
  {scope: "source.lisp",
   name: "defun",
   content: 
    "(defun ${1:name} (${2:parameters})\n\t\"${3:Documentation for $1.}\"\n\t($0))"},
 "mac" => 
  {scope: "source.lisp",
   name: "defmacro",
   content: 
    "(defmacro ${1:name} (${2:parameters})\n\t\"${3:Documentation for $1.}\"\n\t($0))"},
 "let" => 
  {scope: "source.lisp",
   name: "let",
   content: "(let (${1:variables})\n\t($0))"},
 "if" => 
  {scope: "source.lisp", name: "if", content: "(if (${1:test})\n\t($0))"},
 "setf" => 
  {scope: "source.lisp",
   name: "setf",
   content: "(setf ${1:place} ${2:value})"},
 "const" => 
  {scope: "source.lisp",
   name: "defconstant",
   content: 
    "(defconstant +${1:name}+ ${2:value}\n\t\"${3:Documentation for $1.}\"))"},
 "var" => 
  {scope: "source.lisp",
   name: "defvar",
   content: 
    "(defvar *${1:name}* ${2:value}\n\t\"${3:Documentation for $1.}\")"},
 "let1" => 
  {scope: "source.lisp",
   name: "let1",
   content: "(let ((${1:variable} ${2:value}))\n\t($0))"}}
