# Encoding: UTF-8

{"|" => 
  {scope: "text.html.twiki markup.other.table",
   name: "Table Cell",
   content: "| ${1:cell}  |$0"},
 "h5" => 
  {scope: "text.html.twiki",
   name: "Header 5",
   content: "---+++++${1:Header5}\n"},
 "def" => 
  {scope: "text.html.twiki",
   name: "Definition",
   content: "   ${1:term}: ${2:definition}"},
 "h1" => 
  {scope: "text.html.twiki", name: "Header 1", content: "---+${1:Header1}\n"},
 "nli3" => 
  {scope: "text.html.twiki",
   name: "Numbered List Element 3",
   content: "         1 $0"},
 "li5" => 
  {scope: "text.html.twiki",
   name: "List Element 5",
   content: "               * $0"},
 "h4" => 
  {scope: "text.html.twiki",
   name: "Header 4",
   content: "---++++${1:Header4}\n"},
 "li4" => 
  {scope: "text.html.twiki",
   name: "List Element 4",
   content: "            * $0"},
 "list" => 
  {scope: "text.html.twiki",
   name: "List",
   content: 
    "   * ${1:list item 1}\n      * ${2:list item 1.1}\n      * ${3:list item 1.2}\n   * ${4:list item 2}\n      * ${5:list item 2.1}\n      * ${6:list item 2.2}"},
 "code" => 
  {scope: "text.html.twiki",
   name: "Verbatim",
   content: "<verbatim>\n\t$0\n</verbatim>"},
 "nli6" => 
  {scope: "text.html.twiki",
   name: "Numbered LIst Element 6",
   content: "                  1 $0"},
 "nli1" => 
  {scope: "text.html.twiki",
   name: "Numbered List Element 1",
   content: "   1 $0"},
 "li3" => 
  {scope: "text.html.twiki", name: "List Element 3", content: "         * $0"},
 "nli4" => 
  {scope: "text.html.twiki",
   name: "Numbered List Element 4",
   content: "            1 $0"},
 "h3" => 
  {scope: "text.html.twiki",
   name: "Header 3",
   content: "---+++${1:Header3}\n"},
 "table" => 
  {scope: "text.html.twiki",
   name: "Table",
   content: 
    "| ${1:head0} | ${2:head1} | ${3:head2} | ${4:head3} |\n| ${5:data} | ${6:data} | ${7:data} | ${8:data} |\n| ${9:data} | ${10:data} | ${11:data} | ${12:data} |\n| ${13:data} | ${14:data} | ${15:data} | ${16:data} |"},
 nil => 
  {scope: "text.html.twiki markup.list.numbered",
   name: "Numbered List Item (↵)",
   content: "\n1 ${1:list item}"},
 "pre" => 
  {scope: "text.html.twiki",
   name: "Preformatted",
   content: "<pre>\n\t$0\n</pre>"},
 "numlist" => 
  {scope: "text.html.twiki",
   name: "Numbered List",
   content: 
    "   1 ${1:list item 1}\n      1 ${2:list item 1.1}\n      1 ${3:list item 1.2}\n   1 ${4:list item 2}\n      1 ${5:list item 2.1}\n      1 ${6:list item 2.2}"},
 "li2" => 
  {scope: "text.html.twiki", name: "List Element 2", content: "      * $0"},
 "li6" => 
  {scope: "text.html.twiki",
   name: "LIst Element 6",
   content: "                  * $0"},
 "h6" => 
  {scope: "text.html.twiki",
   name: "Header 6",
   content: "---++++++${1:Header6}\n"},
 "li1" => 
  {scope: "text.html.twiki", name: "List Element 1", content: "   * $0"},
 "nli2" => 
  {scope: "text.html.twiki",
   name: "Numbered List Element 2",
   content: "      1 $0"},
 "nli5" => 
  {scope: "text.html.twiki",
   name: "Numbered List Element 5",
   content: "               1 $0"},
 "h2" => 
  {scope: "text.html.twiki", name: "Header 2", content: "---++${1:Header2}\n"},
 "link" => 
  {scope: "text.html.twiki",
   name: "Link",
   content: "[[${1:url or twiki link}][${2:description}]]"},
 "row" => 
  {scope: "text.html.twiki",
   name: "Table Row",
   content: "| ${1:data} | ${2:data} | ${3:data} | ${4:data} |"}}
