# Encoding: UTF-8

{";; @" => 
  {scope: "source.lsp",
   name: "@syntax",
   content: ";; @syntax (${1:function-name} <${2:arg}>$3)"},
 nil => 
  {scope: "comment.doc.lsp", name: "Continue doc comment", content: "\n;; $0"},
 "(define-macro" => 
  {scope: "source.lsp",
   name: "define-macro",
   content: "(define-macro (${1:name})\n\t\"${2:doc-string}\"\n\t${3:body}"},
 "(let" => 
  {scope: "source.lsp",
   name: "let",
   content: "(let ((${1:symbol} ${2:value}))\n\t${3:body}"},
 "(letn" => 
  {scope: "source.lsp",
   name: "letn",
   content: "(letn ((${1:symbol} ${2:value}))\n\t${3:body}"},
 "(define" => 
  {scope: "source.lsp",
   name: "define",
   content: 
    "(define (${1:name} ${2:arg})\n\t\"${3:doc-string}\"\n\t${4:body}"},
 "(letex" => 
  {scope: "source.lsp",
   name: "letex",
   content: "(letex ((${1:symbol} ${2:value}))\n\t${3:body}"},
 "(local" => 
  {scope: "source.lsp",
   name: "local",
   content: "(local (${1:symbol})\n\t${2:body}"}}
