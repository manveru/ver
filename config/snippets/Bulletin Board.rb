# Encoding: UTF-8

{nil => 
  {scope: "text.bbcode",
   name: "Underline",
   content: "[U]${1:${TM_SELECTED_TEXT:underlined text}}[/U]$2"},
 "code" => 
  {scope: "text.bbcode", name: "Code Block", content: "[CODE]$1[/CODE]"},
 "img" => 
  {scope: "text.bbcode", name: "Image", content: "[IMG]${1:source}[/IMG]$2"},
 "url" => 
  {scope: "text.bbcode",
   name: "Link",
   content: "[URL=${1:url}]${2:link text}[/URL]$3"},
 "list" => 
  {scope: "text.bbcode",
   name: "New List",
   content: "[LIST${1:=1}]\n[*] ${2:item 1}\n[/LIST]"},
 "quote" => 
  {scope: "text.bbcode",
   name: "Quotation",
   content: 
    "[QUOTE]Originally posted by ${1:user}:\n${2:quotation}[/QUOTE]\n$3"}}
