# Encoding: UTF-8

{nil => 
  {scope: "text.html.dokuwiki",
   name: "Underlined",
   content: "__${TM_SELECTED_TEXT:text}__"},
 "code" => 
  {scope: "text.html.dokuwiki",
   name: "Code",
   content: "<code>\n$1\n</code>\n$0"},
 "fn" => {scope: "text.html.dokuwiki", name: "Footnote", content: "(($1))"},
 "h1" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 1",
   content: "====== ${1:heading} ======\n"},
 "h2" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 2",
   content: "===== ${1:heading} =====\n"},
 "h3" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 3",
   content: "==== ${1:heading} ====\n"},
 "h4" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 4",
   content: "=== ${1:heading} ===\n"},
 "h5" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 5",
   content: "== ${1:heading} ==\n"},
 "img" => 
  {scope: "text.html.dokuwiki",
   name: "Image",
   content: "{{${1:image}|${2:caption}}}"},
 "lh" => 
  {scope: "text.html.dokuwiki",
   name: "Left Header",
   content: "^ ${1:header} |$0"},
 "link" => {scope: "text.html.dokuwiki", name: "Link", content: "[[$1|$2]]$0"},
 "nu" => {scope: "text.html.dokuwiki", name: "Numbered list", content: "  - "},
 "|" => 
  {scope: "text.html.dokuwiki",
   name: "Table Cell",
   content: "| ${1:cell} |$0"},
 "tab" => 
  {scope: "text.html.dokuwiki",
   name: "Table",
   content: 
    "^ ${1:head0} ^ ${2:head1} ^ ${3:head2} ^\n| ${4:data} | ${5:data} | ${6:data} | \n| ${7:data} | ${8:data} | ${9:data} | \n| ${10:data} | ${11:data} | ${12:data} |\n"},
 "^" => 
  {scope: "text.html.dokuwiki",
   name: "Top Header",
   content: "^ ${1:header} ^$0"},
 "un" => 
  {scope: "text.html.dokuwiki", name: "Unnumbered list", content: "  * "}}
