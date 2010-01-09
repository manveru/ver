# Encoding: UTF-8

{"fori" => 
  {scope: "source.lua",
   name: "for i,v in ipairs()",
   content: 
    "for ${1:i},${2:v} in ipairs(${3:table_name}) do\n\t${0:print(i,v)}\nend"},
 "for" => 
  {scope: "source.lua",
   name: "for i=1,10",
   content: "for ${1:i}=${2:1},${3:10} do\n\t${0:print(i)}\nend"},
 "forp" => 
  {scope: "source.lua",
   name: "for k,v in pairs()",
   content: 
    "for ${1:k},${2:v} in pairs(${3:table_name}) do\n\t${0:print(k,v)}\nend"},
 "fun" => 
  {scope: "source.lua",
   name: "function",
   content: "function ${1:function_name}( ${2:...} )\n\t${0:-- body}\nend"},
 "function" => 
  {scope: "source.lua",
   name: "function",
   content: "function ${1:function_name}( ${2:...} )\n\t${0:-- body}\nend"},
 "local" => 
  {scope: "source.lua", name: "local x = 1", content: "local ${1:x} = ${0:1}"},
 "table.concat" => 
  {scope: "source.lua",
   name: "table.concat",
   content: 
    "table.concat( ${1:tablename}${2:, \", \"}${3:, start_index}${4:, end_index} )"},
 "table.sort" => 
  {scope: "source.lua",
   name: "table.sort",
   content: "table.sort( ${1:tablename}${2:, sortfunction} )"}}
