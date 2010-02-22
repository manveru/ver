# Encoding: UTF-8

{"inc" => 
  {scope: "source.active4d - text.xml",
   name: "include ..",
   content: "include(\"${1:file}${2:.a4d}\")$0"},
 "qs" => 
  {scope: "source.active4d - text.xml",
   name: "query selection..",
   content: "query selection([${1:table}]; [$1]${2:field})$0"},
 "dc" => 
  {scope: "source.active4d - text.xml",
   name: "a4d.debug.dump collection ..",
   content: "a4d.debug.dump collection(${1:\\$collection})\n$0"},
 "wh" => 
  {scope: "source.active4d - text.xml",
   name: "while .. end while",
   content: "while (${1:condition})\n\t$0\nend while"},
 "for" => 
  {scope: "source.active4d - text.xml",
   name: "for .. end for",
   content: "for (${1:\\$i}; ${2:1}; ${3:end})\n\t$0\nend for"},
 "xfa" => 
  {scope: "source.active4d text.xml",
   name: "XFA",
   content: "<string name=\"\\$XFA_$1\" $2/>$0"},
 "arl" => 
  {scope: "source.active4d - text.xml",
   name: "array longint ..",
   content: "array longint(${1:\\$array}; ${2:0})$0"},
 "fr" => 
  {scope: "source.active4d - text.xml",
   name: "fusebox redirect ..",
   content: "redirect(fusebox.makeUrl(\\$XFA_$1))$0"},
 "fm" => 
  {scope: "source.active4d - text.xml",
   name: "fusebox.makeUrl ..",
   content: "fusebox.makeUrl(\\$XFA_$1${2:; query})$0"},
 "dat" => 
  {scope: "source.active4d - text.xml",
   name: "a4d.debug.dump collection($attributes)",
   content: "a4d.debug.dump collection(\\$attributes)\n$0"},
 "rs" => 
  {scope: "source.active4d - text.xml",
   name: "RowSet.newFromSelection ..",
   content: 
    "\\$${1:query} := RowSet.newFromSelection(->[${2:table}]; ${3:\\$map})$0"},
 "st" => 
  {scope: "source.active4d text.xml",
   name: "<string .. />",
   content: "<string name=\"${1:name}\" $2/>$0"},
 "ard" => 
  {scope: "source.active4d - text.xml",
   name: "array date ..",
   content: "array date(${1:\\$array}; ${2:0})$0"},
 "da" => 
  {scope: "source.active4d - text.xml",
   name: "a4d.debug.dump array ..",
   content: "a4d.debug.dump array(${1:\\$array})\n$0"},
 "fet" => 
  {scope: "source.active4d - text.xml",
   name: "for each (table) .. end for each",
   content: "for each ([${1:table}]${2:; \\$index})\n\t$0\nend for each"},
 "whe" => 
  {scope: "source.active4d - text.xml",
   name: "while (not(end selection([..]))) end while",
   content: 
    "while (not(end selection([${1:table}])))\n\t$0\n\n\tnext record([$1])\nend while"},
 "ife" => 
  {scope: "source.active4d - text.xml",
   name: "if .. else end if",
   content: "if (${1:condition})\n\t$0\nelse\n\t\nend if"},
 "ars" => 
  {scope: "source.active4d - text.xml",
   name: "array string ..",
   content: "array string(${1:31}; ${2:\\$array}; ${3:0})$0"},
 "arb" => 
  {scope: "source.active4d - text.xml",
   name: "array boolean ..",
   content: "array boolean(${1:\\$array}; ${2:0})$0"},
 "at" => 
  {scope: "source.active4d - text.xml",
   name: "$attributes ..",
   content: "\\$attributes{\"${1:key}\"}$0"},
 "ards" => 
  {scope: "source.active4d - text.xml",
   name: "array date * ..",
   content: "array date(${1:\\$array}; *; ${2:date})$0"},
 "sh" => 
  {scope: "text.html.strict.active4d",
   name: "Standard Header",
   content: 
    "<% /*\n<fusedoc fuse=\"${TM_FILENAME:filename.a4d}\" language=\"Active4D\" specification=\"2.0\">\n\t<responsibilities>\n\t\t$1\n\t</responsibilities>\t\n\t<io>\n\t\t<in>$2\n\t\t</in>\n\t\t<out>$3\n\t\t</out>\n\t</io>\n</fusedoc>\n\n\\$Id\\$\n*/ \n\n$0\n%>"},
 "fora" => 
  {scope: "source.active4d - text.xml",
   name: "for ( .. size of array(..)) .. end for",
   content: 
    "for (${1:\\$i}; ${2:1}; size of array(${3:\\$array}))\n\t$0\nend for"},
 "fea" => 
  {scope: "source.active4d - text.xml",
   name: "for each (array) .. end for each",
   content: 
    "for each (${1:\\$array}; ${2:\\$value}${3:; \\$index})\n\t$0\nend for each"},
 "ch" => 
  {scope: "source.active4d - text.xml",
   name: "choose ..",
   content: "choose(${1:condition}; ${2:true_value}; ${3:false_value})$0"},
 "arrs" => 
  {scope: "source.active4d - text.xml",
   name: "array real * ..",
   content: "array real(${1:\\$array}; *; ${2:real})$0"},
 "q" => 
  {scope: "source.active4d - text.xml",
   name: "query ..",
   content: "query([${1:table}]; [$1]${2:field})$0"},
 "wl" => 
  {scope: "source.active4d - text.xml",
   name: "writeln ..",
   content: "writeln($1)$0"},
 "arts" => 
  {scope: "source.active4d - text.xml",
   name: "array text * ..",
   content: "array text(${1:\\$array}; *; \"${2:text}\")$0"},
 "if" => 
  {scope: "source.active4d - text.xml",
   name: "if .. end if",
   content: "if (${1:condition})\n\t$0\nend if"},
 "=" => 
  {scope: "text.html.strict.active4d - source.active4d",
   name: "Active4D = block",
   content: "<%= $1 %>$0"},
 "sa" => 
  {scope: "source.active4d - text.xml",
   name: "size of array ..",
   content: "size of array(${1:\\$array})$0"},
 "me" => 
  {scope: "source.active4d - text.xml",
   name: "method .. end method",
   content: "method \"${1:name}\"\n\t$0\nend method"},
 "arss" => 
  {scope: "source.active4d - text.xml",
   name: "array string * ..",
   content: "array string(${1:31}; ${2:\\$array}; *; \"${3:string}\")$0"},
 "ris" => 
  {scope: "source.active4d - text.xml",
   name: "records in selection ..",
   content: "records in selection([${1:table}])$0"},
 "ff" => 
  {scope: "source.active4d text.xml",
   name: "<string .. /> from form field",
   content: 
    "<string name=\"${1:name}\" scope=\"attributes\" optional=\"${2:yes}\"${3: comments=\"$4\"} />$0"},
 "wb" => 
  {scope: "source.active4d - text.xml",
   name: "writebr ..",
   content: "writebr($1)$0"},
 "fa" => 
  {scope: "source.active4d - text.xml",
   name: "find in array ..",
   content: "find in array(${1:\\$array}; ${2:value}${3:; start})$0"},
 "rep" => 
  {scope: "source.active4d - text.xml",
   name: "repeat .. until",
   content: "repeat\n\t$0\nuntil (${1:condition})"},
 "wc" => 
  {scope: "source.active4d - text.xml",
   name: "write to console ..",
   content: "write to console($1)$0"},
 "w" => 
  {scope: "source.active4d - text.xml",
   name: "write ..",
   content: "write($1)$0"},
 "ss" => 
  {scope: "source.active4d text.xml",
   name: "<string .. /> from session",
   content: "<string name=\"${1:name}\" scope=\"session\" $2/>$0"},
 "case" => 
  {scope: "source.active4d - text.xml",
   name: "case of .. end case",
   content: "case of\n\t:(${1:condition})\n\t\t$0\nend case"},
 "art" => 
  {scope: "source.active4d - text.xml",
   name: "array text ..",
   content: "array text(${1:\\$array}; ${2:0})$0"},
 "mp" => 
  {scope: "source.active4d - text.xml",
   name: "method (..) .. end method",
   content: "method \"${1:name}\"(${2:\\$parameter})\n\t$0\nend method"},
 "css" => 
  {scope: "source.active4d - text.xml",
   name: "fusebox.head.addCSS ..",
   content: "fusebox.head.addCSS(\\$fusebox; \"${1:stylesheet}.css$0\")"},
 "arls" => 
  {scope: "source.active4d - text.xml",
   name: "array longint * ..",
   content: "array longint(${1:\\$array}; *; ${2:longint})$0"},
 "js" => 
  {scope: "source.active4d - text.xml",
   name: "fusebox.head.addJS ..",
   content: "fusebox.head.addJS(\\$fusebox; \"${1:javascript}.js$0\")"},
 "arbs" => 
  {scope: "source.active4d - text.xml",
   name: "array boolean * ..",
   content: "array boolean(${1:\\$array}; *; ${2:true/false})$0"},
 "sat" => 
  {scope: "source.active4d text.xml",
   name: "<string .. /> from attributes",
   content: "<string name=\"${1:name}\" scope=\"attributes\" $2/>$0"},
 "date" => 
  {scope: "source.active4d text.xml",
   name: "<date ../>",
   content: "<date name=\"${1:name}\" $2/>$0"},
 "time" => 
  {scope: "source.active4d text.xml",
   name: "<time .. />",
   content: "<time name=\"${1:name}\" $2/>$0"},
 "casee" => 
  {scope: "source.active4d - text.xml",
   name: "case of .. else end case",
   content: "case of\n\t:(${1:condition})\n\t\t$0\n\nelse\n\t\nend case"},
 "s" => 
  {scope: "source.active4d - text.xml",
   name: "session{..}",
   content: "session{\"${1:key}\"}$0"},
 "bool" => 
  {scope: "source.active4d text.xml",
   name: "<boolean .. />",
   content: "<boolean name=\"${1:name}\" $2/>$0"},
 "num" => 
  {scope: "source.active4d text.xml",
   name: "<number .. />",
   content: "<number name=\"${1:name}\" $2/>$0"},
 "fes" => 
  {scope: "source.active4d - text.xml",
   name: "for each (string) .. end for each",
   content: 
    "for each (${1:\\$string}; ${2:\\$char}${3:; \\$index})\n\t$0\nend for each"},
 "ob" => 
  {scope: "source.active4d - text.xml",
   name: "order by ..",
   content: "order by([${1:table}]; [$1]${2:field}${3:; >}$0)"},
 "arr" => 
  {scope: "source.active4d - text.xml",
   name: "array real ..",
   content: "array real(${1:\\$array}; ${2:0})$0"},
 "<" => 
  {scope: "text.html.strict.active4d - source.active4d",
   name: "Active4D code block",
   content: "<%$1$2%>$0"},
 "fec" => 
  {scope: "source.active4d - text.xml",
   name: "for each (collection) .. end for each",
   content: 
    "for each (${1:\\$collection}; ${2:\\$key}${3:; \\$value})\n\t$0\nend for each"},
 "sta" => 
  {scope: "source.active4d - text.xml",
   name: "selection to array ..",
   content: "selection to array([${1:table}]${2:field}; ${3:\\$array})$0"}}
