# Encoding: UTF-8

{"until" => 
  {scope: "source.slate",
   name: "until",
   content: "[${1:condition}] whileFalse: [$2:body]"},
 "if" => 
  {scope: "source.slate",
   name: "If-then",
   content: "${1:condition} ifTrue: [$2:then]"},
 "ifte" => 
  {scope: "source.slate",
   name: "If-then-else",
   content: "${1:condition} ifTrue: [$2:then] ifFalse: [$3:else]"},
 "proto" => 
  {scope: "source.slate",
   name: "define prototype",
   content: 
    "define: \#${1:NewName} &parents: {${2:parents}}\n &slots: {${3:slotSpecs}}.\n"},
 "[" => 
  {scope: "source.slate",
   name: "Block Header",
   content: 
    "[${1/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/} ${1:variable} ${1/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:| )/}${2:$TM_SELECTED_TEXT} "},
 "dowith" => 
  {scope: "source.slate",
   name: "doWithIndex",
   content: "doWithIndex: [| :${1:each} :${2:index} | $0]"},
 "inject" => 
  {scope: "source.slate",
   name: "inject into",
   content: "inject: ${1:object} [| :${2:injection}, :${3:each}| $0]"},
 "reject" => 
  {scope: "source.slate",
   name: "reject",
   content: "reject: [| :${1:each}| $0]"},
 "collect" => 
  {scope: "source.slate",
   name: "collect",
   content: "collect: [| :${1:each}| $0]"},
 "while" => 
  {scope: "source.slate",
   name: "while",
   content: "[${1:condition}] whileTrue: [$2:body]"},
 "select" => 
  {scope: "source.slate",
   name: "select",
   content: "select: [| :${1:each}| $0]"},
 "do" => 
  {scope: "source.slate", name: "do", content: "do: [| :${1:each}| $0]"}}
