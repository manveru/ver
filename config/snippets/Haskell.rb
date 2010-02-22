# Encoding: UTF-8

{"mod" => 
  {scope: "source.haskell",
   name: "Module",
   content: 
    "module ${1:Main} where\n\n${2:main = ${3:putStrLn \"Hello World\"}}"},
 "\\" => 
  {scope: "source.haskell",
   name: "\\t -> f t",
   content: "\\\\${1:t} -> ${0:f t}"},
 "main" => 
  {scope: "source.haskell",
   name: "Main",
   content: "module Main where\n\nmain = ${1:putStrLn \"Hello World\"}"},
 "instance" => 
  {scope: "source.haskell",
   name: "Instance",
   content: "instance ${1:Class} ${2:Data} where\n\t${3:func} = $0"},
 nil => 
  {scope: "source.haskell", name: "t <- f t", content: "${1:t} <- ${0:f t}"},
 "case" => 
  {scope: "source.haskell",
   name: "Case",
   content: 
    "case ${1:a} of ${2:True} -> ${3:$1}\n\t${1/./ /g}     ${4:otherwise} -> ${0:$1}"}}
