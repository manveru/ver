# Encoding: UTF-8

{"switch" => 
  {scope: "source.tcl",
   name: "switch...",
   content: 
    "switch ${1:-exact} -- ${2:\\$var} {\n\t${3:match} {\n\t\t${4}\n\t}\n\tdefault {${5}}\n}\n"},
 "if" => 
  {scope: "source.tcl",
   name: "if...",
   content: "if {${1:condition}} {\n\t${2}\n}\n"},
 "proc" => 
  {scope: "source.tcl",
   name: "proc...",
   content: "proc ${1:name} {${2:args}} \\\\\n{\n\t${3}\n}\n"},
 "foreach" => 
  {scope: "source.tcl",
   name: "foreach...",
   content: "foreach ${1:var} ${2:\\$list} {\n\t${3}\n}\n"},
 "while" => 
  {scope: "source.tcl",
   name: "while...",
   content: "while {${1:condition}} {\n\t${2}\n}\n"},
 "for" => 
  {scope: "source.tcl",
   name: "for...",
   content: 
    "for {${1:set i 0}} {${2:\\$i < \\$n}} {${3:incr i}} {\n\t${4}\n}\n"}}
