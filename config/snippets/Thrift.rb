# Encoding: UTF-8

{"ser" => 
  {scope: "source.thrift -meta",
   name: "service",
   content: 
    "service ${1:Name}${2/.+/ extends /m}${2:Super} {\n\t${3:void} ${4:method}(${5:args})\n}"},
 "exc" => 
  {scope: "source.thrift -meta",
   name: "exception",
   content: "exception ${1:Name} {\n\t1: string message,$0\n}"},
 "str" => 
  {scope: "source.thrift -meta",
   name: "struct",
   content: 
    "struct ${1:Name} {\n\t${2:1}${2/.+/: /m}${3:i32} ${4:field}${5/.+/ = /m}${5:value},$0\n}"},
 "enu" => 
  {scope: "source.thrift -meta",
   name: "enum",
   content: "enum ${1:Name} {\n\t${2:FIELD} = ${3:1},$0\n}"}}
