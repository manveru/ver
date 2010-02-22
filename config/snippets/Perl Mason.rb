# Encoding: UTF-8

{"method" => 
  {scope: "text.html.mason",
   name: "<%method>",
   content: "<%method ${1:name}>\n$2\n</%method>"},
 "def" => 
  {scope: "text.html.mason",
   name: "<%def>",
   content: "<%def ${1:name}>\n$2\n</%def>"},
 "init" => 
  {scope: "text.html.mason",
   name: "<%init>",
   content: "<%init>\n$1\n</%init>\n"},
 "doc" => 
  {scope: "text.html.mason", name: "<%doc>", content: "<%doc> $1 </%doc>"},
 "flags" => 
  {scope: "text.html.mason",
   name: "<%flags>",
   content: "<%flags>\n$1\n</%flags>\n"},
 "args" => 
  {scope: "text.html.mason",
   name: "<%args>",
   content: "<%args>\n$1\n</%args>"},
 nil => 
  {scope: "text.html.mason",
   name: "<& component &> with content </&>",
   content: "<&| $1 &>\n$2\n</&>\n"},
 "perl" => 
  {scope: "text.html.mason",
   name: "<%perl>",
   content: "<%perl>\n$1\n</%perl>"}}
