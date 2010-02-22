# Encoding: UTF-8

{"r.f" => 
  {scope: "source.asp",
   name: "Request.Form(\"…\")",
   content: "Request.Form(\"${1:field}\")"},
 "ifelse" => 
  {scope: "source.asp",
   name: "If … End if",
   content: 
    "If ${1:condition} Then\n\t${2:' true}\nElse\n\t${3:' false}\nEnd if"},
 "sess" => 
  {scope: "source.asp",
   name: "Session(\"…\")",
   content: "Session(\"${1:whatever}\")"},
 "r.w" => 
  {scope: "source.asp", name: "Response.Write", content: "Response.Write "},
 "app" => 
  {scope: "source.asp",
   name: "Application(\"…\")",
   content: "Application(\"$1\")"},
 "forin" => 
  {scope: "source.asp",
   name: "For … in … Next",
   content: "For ${1:var} in ${2:array}\n\t${3:' body}\nNext"},
 "r.q" => 
  {scope: "source.asp",
   name: "Request.QueryString",
   content: "Request.QueryString(\"${1:name}\")"},
 "=" => {scope: "source.asp", name: "<%= %>", content: "<%= $0 %>"},
 "r.r" => 
  {scope: "source.asp",
   name: "Response.Redirect",
   content: "Response.Redirect(${1:to})"},
 "while" => 
  {scope: "source.asp",
   name: "While … Wend",
   content: "While ${1:NOT ${2:condition}}\n\t${3:' body}\nWend"}}
