# Encoding: UTF-8

{"ones" => 
  {scope: "source.scilab",
   name: "ones(..)",
   content: "ones(${1:rows}, ${2:cols})"},
 "plot" => 
  {scope: "source.scilab",
   name: "plot(..)",
   content: "plot(${1:x}, ${2:y}, ${3:'-'})"},
 "case" => 
  {scope: "source.scilab",
   name: "case",
   content: "case ${1:expression} then\n\t$0"},
 "plot3d" => 
  {scope: "source.scilab",
   name: "plot3d(..)",
   content: "plot3d(${1:x}, ${2:y}, ${3:z})"},
 "if" => 
  {scope: "source.scilab",
   name: "if ... end",
   content: "if ${1:condition} then\n\t$0\nend"},
 "zeros" => 
  {scope: "source.scilab",
   name: "zeros(..)",
   content: "zeros(${1:rows}, ${2:cols})"},
 "elseif" => 
  {scope: "source.scilab",
   name: "elseif",
   content: "elseif ${1:condition} then\n\t$0"},
 "select" => 
  {scope: "source.scilab",
   name: "select ... case ... end",
   content: "select ${1:variable}\n\tcase ${2:expression} then\n\t\t$0\nend"},
 "function" => 
  {scope: "source.scilab",
   name: "function",
   content: 
    "function ${3:output} = ${1:name}($2)\n\t// ${4:Description of $1($2)}\nendfunction"},
 "path" => 
  {scope: "source.scilab",
   name: "get_absolute_file_path(..)",
   content: 
    "get_absolute_file_path(\"${0:`echo \"$TM_FILEPATH\" | sed -e \"s/'/''/g\" -e \"s/\\\"/\\\"\\\"/g\"`}\");"},
 "eye" => 
  {scope: "source.scilab",
   name: "eye(..)",
   content: "eye(${1:size}, ${2:$1})"},
 "legend" => 
  {scope: "source.scilab",
   name: "legend(..)",
   content: "legend(\"${1:Graph 1}\", \"${2:Graph 2}\")"},
 "getd" => 
  {scope: "source.scilab",
   name: "getd(..)",
   content: 
    "getd(\"${0:`echo \"$TM_DIRECTORY\" | sed -e \"s/'/''/g\" -e \"s/\\\"/\\\"\\\"/g\"`}\")"},
 "ifelse" => 
  {scope: "source.scilab",
   name: "if ... else ... end",
   content: "if ${1:condition} then\n\t$2\nelse\n\t$3\nend"},
 "title" => 
  {scope: "source.scilab",
   name: "xtitle(..)",
   content: "xtitle(\"${1:Main Title}\", \"${2:x-axis}\", \"${3:y-axis}\")"},
 "while" => 
  {scope: "source.scilab",
   name: "while ... end",
   content: "while ${1:condition} then\n\t$0\nend"},
 "exec" => 
  {scope: "source.scilab",
   name: "exec(..)",
   content: "exec(\"${0:script.sce}\")"},
 "for" => 
  {scope: "source.scilab",
   name: "for ... end",
   content: "for ${1:i} = ${2:array}\n\t$0\nend"},
 "getf" => 
  {scope: "source.scilab",
   name: "getf(..)",
   content: "getf(\"${0:script.sci}\")"}}
