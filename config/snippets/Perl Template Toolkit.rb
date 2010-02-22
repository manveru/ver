# Encoding: UTF-8

{"inc" => 
  {scope: "text.html.tt",
   name: "include",
   content: "[% INCLUDE ${1:template} %]"},
 "wrap" => 
  {scope: "text.html.tt",
   name: "wrapper",
   content: "[% WRAPPER ${1:template} %]\n\t$2\n[% END %]"},
 "for" => 
  {scope: "text.html.tt",
   name: "for",
   content: "[% FOR ${1:var} IN ${2:set} %]\n\t$3\n[% END %]"},
 "unl" => 
  {scope: "text.html.tt",
   name: "unless",
   content: "[% UNLESS ${1:condition} %]\n\t$2\n[% END %]"},
 "if" => 
  {scope: "text.html.tt",
   name: "if",
   content: "[% IF ${1:condition} %]\n\t$2\n[% ELSE %]\n\t$3\n[% END %]"}}
