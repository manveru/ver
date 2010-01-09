# Encoding: UTF-8

{"image" => 
  {scope: "text.restructuredtext",
   name: "image",
   content: ".. image:: ${1:path}\n$0"},
 "link" => 
  {scope: "text.restructuredtext",
   name: "link",
   content: "\n\\`${1:Title}<${2:http://link}>\\`_"},
 "sec" => 
  {scope: "text.restructuredtext",
   name: "section 1",
   content: "${1:subsection name}\n${1/(.)|\\s/(?1:=:=)/g}\n$0"},
 "subs" => 
  {scope: "text.restructuredtext",
   name: "section 2",
   content: "${1:subsection name}\n${1/(.)|\\s/(?1:*:*)/g}\n$0"},
 "sss" => 
  {scope: "text.restructuredtext",
   name: "section 3",
   content: "${1:subsection name}\n${1/(.)|\\s/(?1:-:-)/g}\n$0"}}
