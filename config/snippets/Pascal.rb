# Encoding: UTF-8

{"begin" => 
  {scope: "source.pascal", name: "begin … end", content: "begin\n\t$0\nend;"},
 "prop" => 
  {scope: "source.pascal",
   name: "property",
   content: 
    "property ${1:PropertyName}: ${2:WideString} read ${3:F}${1} write ${4:F}${1};$0"},
 "unit" => 
  {scope: "source.pascal",
   name: "unit … implementation … end",
   content: 
    "unit ${1:unit_name};\n\ninterface\n\nuses\n\tSysUtils${2:, Classes};\n\nimplementation\n\n$0\n\nend."},
 nil => {scope: "source.pascal", name: "Newline", content: "#13#10"},
 "if" => 
  {scope: "source.pascal",
   name: "if … end",
   content: "if ${1} then begin\n\t$0\nend;"},
 "constructor" => 
  {scope: "source.pascal",
   name: "constructor, destructor",
   content: "constructor Create${1:()};\ndestructor Destroy; override;$0"},
 "for" => 
  {scope: "source.pascal",
   name: "for … end",
   content: "for ${1:i} := ${2:0} to ${3:max} do begin\n\t$0\nend;"},
 "class" => 
  {scope: "source.pascal",
   name: "class … end",
   content: "T${1:ClassName} = class\n\t$0\nend;"},
 "try" => 
  {scope: "source.pascal",
   name: "try … finally",
   content: "try\n\t$0\nfinally\n\t$1\nend;"}}
