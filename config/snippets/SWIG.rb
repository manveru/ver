# Encoding: UTF-8

{"feat" => 
  {scope: "source.swig",
   name: "%feature",
   content: "%feature(\"${1:name}\") $2; "},
 "temp" => 
  {scope: "source.swig",
   name: "%template",
   content: "%template(${1:name}) ${2:type};"},
 "inc" => {scope: "source.swig", name: "%include", content: "%include \"$1\""},
 "ign" => {scope: "source.swig", name: "%ignore", content: "%ignore $1;"},
 "mod" => 
  {scope: "source.swig",
   name: "%module",
   content: "%module${1:($2)} \"${3:name}\""},
 "re" => 
  {scope: "source.swig",
   name: "%rename",
   content: "%rename(${1:new_name}) ${2:old_name};"}}
