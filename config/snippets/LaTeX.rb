# Encoding: UTF-8

{nil => 
  {scope: "text.tex.latex",
   name: "Unnumbered Equation",
   content: "\\\\[\n\t$0\n\\\\]"},
 "subs" => 
  {scope: "text.tex.latex",
   name: "Sub Sub Section",
   content: 
    "\\subsubsection{${1:subsubsection name}} % (fold)\n\\label{ssub:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% subsubsection $2 (end)"},
 "$$" => 
  {scope: "text.tex.latex",
   name: "Display Math — \\[ … \\]",
   content: "\\[\n\t$TM_SELECTED_TEXT$1\n\\]"},
 "itd" => 
  {scope: "text.tex.latex meta.function.environment.list",
   name: "\\item[description]",
   content: "\\\\item[${1:description}] ${0:item}"},
 "sub" => 
  {scope: "text.tex.latex",
   name: "Sub Section",
   content: 
    "\\subsection{${1:subsection name}} % (fold)\n\\label{sub:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% subsection $2 (end)"},
 "sec" => 
  {scope: "text.tex.latex",
   name: "Section",
   content: 
    "\\section{${1:section name}} % (fold)\n\\label{sec:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% section $2 (end)"},
 "eq" => 
  {scope: "text.tex.latex",
   name: "Equation",
   content: "\\begin{equation}\n\t$0\n\\end{equation}"},
 "ali" => 
  {scope: "text.tex.latex",
   name: "Align(ed)",
   content: 
    "\\begin{align`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}\n\t$0\n\\end{align`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}"},
 "part" => 
  {scope: "text.tex.latex",
   name: "Part",
   content: 
    "\\part{${1:part name}} % (fold)\n\\label{prt:${2:${1/(\\w+)|\\W+/(?1:\\L$0:_)/g}}}\n${0:$TM_SELECTED_TEXT}\n% part $2 (end)"},
 "par" => 
  {scope: "text.tex.latex",
   name: "Paragraph",
   content: 
    "\\paragraph{${1:paragraph name}} % (fold)\n\\label{par:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% paragraph $2 (end)"},
 "tab" => 
  {scope: "text.tex.latex",
   name: "Tabular",
   content: 
    "\\\\begin{${1:t}${1/(t)$|(a)$|(.*)/(?1:abular)(?2:rray)/}}{${2:c}}\n$0${2/((?<=.)c|l|r)|./(?1: & )/g}\n\\\\end{${1:t}${1/(t)$|(a)$|(.*)/(?1:abular)(?2:rray)/}}"},
 "enum" => 
  {scope: "text.tex.latex",
   name: "Enumerate",
   content: "\\\\begin{enumerate}\n\t\\item $0\n\\\\end{enumerate}"},
 "page" => 
  {scope: "text.tex.latex",
   name: "Page",
   content: "${1:page}~\\pageref{$2}$0\n"},
 "figure" => 
  {scope: "text.tex.latex",
   name: "Figure",
   content: "${1:Figure}~\\ref{${2:fig:}}$0"},
 "listing" => 
  {scope: "text.tex.latex",
   name: "Listing",
   content: "${1:Listing}~\\ref{${2:lst:}}$0\n"},
 "section" => 
  {scope: "text.tex.latex",
   name: "Section",
   content: "${1:Section}~\\ref{${2:sec:}}$0\n"},
 "item" => 
  {scope: "text.tex.latex",
   name: "Itemize",
   content: "\\\\begin{itemize}\n\t\\item $0\n\\\\end{itemize}"},
 "mat" => 
  {scope: "text.tex.latex",
   name: "Matrix",
   content: 
    "\\begin{${1:p/b/v/V/B/small}matrix}\n\t$0\n\\end{${1:p/b/v/V/B/small}matrix}"},
 "spl" => 
  {scope: "text.tex.latex",
   name: "Split",
   content: "\\begin{split}\n\t$0\n\\end{split}"},
 "begin" => 
  {scope: "text.tex.latex",
   name: "\\begin{}…\\end{}",
   content: 
    "\\\\begin{${1:env}}\n\t${1/(enumerate|itemize|list)|(description)|.*/(?1:\\item )(?2:\\item)/}$0\n\\\\end{${1:env}}"},
 "subp" => 
  {scope: "text.tex.latex",
   name: "Sub Paragraph",
   content: 
    "\\subparagraph{${1:subparagraph name}} % (fold)\n\\label{subp:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% subparagraph $2 (end)"},
 "desc" => 
  {scope: "text.tex.latex",
   name: "Description",
   content: "\\\\begin{description}\n\t\\item[$1] $0\n\\\\end{description}"},
 "table" => 
  {scope: "text.tex.latex",
   name: "Table",
   content: "${1:Table}~\\ref{${2:tab:}}$0"},
 "gat" => 
  {scope: "text.tex.latex",
   name: "Gather(ed)",
   content: 
    "\\begin{gather`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}\n\t$0\n\\end{gather`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}"},
 "cas" => 
  {scope: "text.tex.latex",
   name: "Cases",
   content: 
    "\\begin{cases}\n\t${1:equation}, &\\text{ if }${2:case}\\\\\\\\\n\t$0\n\\end{cases}"},
 "cha" => 
  {scope: "text.tex.latex",
   name: "Chapter",
   content: 
    "\\chapter{${1:chapter name}} % (fold)\n\\label{cha:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% chapter $2 (end)"}}
