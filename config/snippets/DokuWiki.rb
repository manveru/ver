# Encoding: UTF-8

{"h4" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 4",
   content: "=== ${1:heading} ===\n"},
 "|" => 
  {scope: "text.html.dokuwiki",
   name: "Table Cell",
   content: "| ${1:cell} |$0"},
 "code" => 
  {scope: "text.html.dokuwiki",
   name: "Code",
   content: "<code>\n$1\n</code>\n$0"},
 "nu" => 
  {scope: "markup.list.numbered.dokuwiki",
   name: "Numbered item",
   content: "\n- "},
 "un" => 
  {scope: "text.html.dokuwiki", name: "Unnumbered list", content: "  * "},
 "h3" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 3",
   content: "==== ${1:heading} ====\n"},
 "fn" => {scope: "text.html.dokuwiki", name: "Footnote", content: "(($1))"},
 "img" => 
  {scope: "text.html.dokuwiki",
   name: "Image",
   content: "{{${1:image}|${2:caption}}}"},
 "lh" => 
  {scope: "text.html.dokuwiki",
   name: "Left Header",
   content: "^ ${1:header} |$0"},
 nil => 
  {scope: "text.html.dokuwiki",
   name: "Italic",
   content: "//${TM_SELECTED_TEXT:text}//"},
 "h2" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 2",
   content: "===== ${1:heading} =====\n"},
 "h5" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 5",
   content: "== ${1:heading} ==\n"},
 "tab" => 
  {scope: "text.html.dokuwiki",
   name: "Table",
   content: 
    "^ ${1:head0} ^ ${2:head1} ^ ${3:head2} ^\n| ${4:data} | ${5:data} | ${6:data} | \n| ${7:data} | ${8:data} | ${9:data} | \n| ${10:data} | ${11:data} | ${12:data} |\n"},
 "link" => {scope: "text.html.dokuwiki", name: "Link", content: "[[$1|$2]]$0"},
 "h1" => 
  {scope: "text.html.dokuwiki",
   name: "Heading 1",
   content: "====== ${1:heading} ======\n"},
 "^" => 
  {scope: "text.html.dokuwiki",
   name: "Top Header",
   content: "^ ${1:header} ^$0"}}
