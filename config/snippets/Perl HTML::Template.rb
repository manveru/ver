# Encoding: UTF-8

{"ife" => 
  {scope: "text.html.html-template",
   name: "If-Else",
   content: "<TMPL_IF NAME=\"$1\">\n\t$2\n<TMPL_ELSE>\n\t$3\n</TMPL_IF>"},
 "if" => 
  {scope: "text.html.html-template",
   name: "If",
   content: "<TMPL_IF NAME=\"$1\">\n\t$2\n</TMPL_IF>"},
 "inc" => 
  {scope: "text.html.html-template",
   name: "Include",
   content: "<TMPL_INCLUDE NAME=\"$1\">"},
 "loop" => 
  {scope: "text.html.html-template",
   name: "Loop",
   content: "<TMPL_LOOP NAME=\"$1\">\n\t$2\n</TMPL_LOOP>"},
 "unless" => 
  {scope: "text.html.html-template",
   name: "Unless",
   content: "<TMPL_UNLESS NAME=\"$1\">\n\t$2\n</TMPL_UNLESS>"},
 "var" => 
  {scope: "text.html.html-template",
   name: "Var",
   content: 
    "<TMPL_VAR NAME=\"$1\"${2:${3: DEFAULT=\"$4\"}${5: ESCAPE=\"${6:html|js|url|none}\"}}>"}}
