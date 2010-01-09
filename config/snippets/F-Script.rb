# Encoding: UTF-8

{"if" => 
  {scope: "source.fscript - string - comment",
   name: "ifFalse:",
   content: "ifFalse:[\n\t$1\n]."},
 "ift" => 
  {scope: "source.fscript - string - comment",
   name: "ifFalse:ifTrue:",
   content: "ifFalse:[\n\t$1\n] ifTrue:[\n\t$2\n]."},
 "it" => 
  {scope: "source.fscript - string - comment",
   name: "ifTrue:",
   content: "ifTrue:[\n\t$1\n]."},
 "itf" => 
  {scope: "source.fscript - string - comment",
   name: "ifTrue:ifFalse",
   content: "ifTrue:[\n\t$1\n] ifFalse:[\n\t$2\n]."},
 "tbd" => 
  {scope: "source.fscript",
   name: "to:by:do:",
   content: "to:$1 by:$2 do:[ ${3::i} |\n\t$4\n]."},
 "td" => 
  {scope: "source.fscript",
   name: "to:do:",
   content: "to:$1 do:[ ${2::i} |\n\t$3\n]."}}
