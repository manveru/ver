# Encoding: UTF-8

{"=" => {scope: "source.asp", name: "<%= %>", content: "<%= $0 %>"},
 "forin" => 
  {scope: "source.asp",
   name: "For … in … Next",
   content: "For ${1:var} in ${2:array}\n\t${3:' body}\nNext"},
 "ifelse" => 
  {scope: "source.asp",
   name: "If … End if",
   content: 
    "If ${1:condition} Then\n\t${2:' true}\nElse\n\t${3:' false}\nEnd if"},
 "while" => 
  {scope: "source.asp",
   name: "While … Wend",
   content: "While ${1:NOT ${2:condition}}\n\t${3:' body}\nWend"},
 "r.f" => 
  {scope: "source.asp",
   name: "Request.Form(\"…\")",
   content: "Request.Form(\"${1:field}\")"},
 "r.q" => 
  {scope: "source.asp",
   name: "Request.QueryString",
   content: "Request.QueryString(\"${1:name}\")"},
 "r.w" => 
  {scope: "source.asp", name: "Response.Write", content: "Response.Write "},
 "r.r" => 
  {scope: "source.asp",
   name: "Response.Redirect",
   content: "Response.Redirect(${1:to})"},
 "app" => 
  {scope: "source.asp",
   name: "Application(\"…\")",
   content: "Application(\"$1\")"},
 "sess" => 
  {scope: "source.asp",
   name: "Session(\"…\")",
   content: "Session(\"${1:whatever}\")"}}
