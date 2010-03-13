# Encoding: UTF-8

[{content: "\\\\\\\\\n$0${TM_CURRENT_LINE/^[^&]+|[^&]+$|([^&]+)/ (?1: )/g}",
  keyEquivalent: "",
  name: "Add Row",
  scope: "text.tex.latex meta.function.environment.tabular.latex",
  uuid: "F59D0C3A-B5AC-40D6-AB07-05CE8CB784A9"},
 {content: 
   "\\begin{align`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}\n\t$0\n\\end{align`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}",
  name: "Align(ed)",
  scope: "text.tex.latex",
  tabTrigger: "ali",
  uuid: "EEAC1CE5-50DD-42B0-96D6-08EB81E58754"},
 {content: "<${1:+-}>",
  keyEquivalent: "^<",
  name: "Beamer Overlay Specification",
  scope: "text.tex.latex.beamer",
  uuid: "BDA02D31-3097-4726-9A93-7AAA4576F676"},
 {content: 
   "\\begin{cases}\n\t${1:equation}, &\\text{ if }${2:case}\\\\\\\\\n\t$0\n\\end{cases}",
  name: "Cases",
  scope: "text.tex.latex",
  tabTrigger: "cas",
  uuid: "EE7D14B5-9620-4A1B-866B-91E26FB481DB"},
 {content: 
   "\\chapter{${1:chapter name}} % (fold)\n\\label{cha:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% chapter $2 (end)",
  name: "Chapter",
  scope: "text.tex.latex",
  tabTrigger: "cha",
  uuid: "47FA7321-6BDC-413B-9F59-63ACBB0E2080"},
 {content: "\\\\${1:text${2:bf}}{$TM_SELECTED_TEXT}",
  keyEquivalent: "^E",
  name: "Command — \\command{…}",
  scope: "text.tex.latex",
  uuid: "7D3548FA-AE80-11D9-8B45-000D93B6E43C"},
 {content: "\\\\begin{description}\n\t\\item[$1] $0\n\\\\end{description}",
  name: "Description",
  scope: "text.tex.latex",
  tabTrigger: "desc",
  uuid: "2F926912-E5E6-4965-8E50-0603765DD0E6"},
 {content: "\\[\n\t$TM_SELECTED_TEXT$1\n\\]",
  keyEquivalent: "^M",
  name: "Display Math — \\[ … \\]",
  scope: "text.tex.latex",
  tabTrigger: "$$",
  uuid: "F38DDE93-BF77-449D-A4C9-6C525ECAC6FB"},
 {content: "\\`\\`$TM_SELECTED_TEXT''",
  keyEquivalent: "^`",
  name: "Double Quotes",
  scope: "text.tex.latex",
  uuid: "903B133A-B073-40C2-83DD-7B1E6D435A26"},
 {content: "\\\\begin{enumerate}\n\t\\item $0\n\\\\end{enumerate}",
  name: "Enumerate",
  scope: "text.tex.latex",
  tabTrigger: "enum",
  uuid: "03F30619-2739-447F-953D-DB225185E4D2"},
 {content: 
   "${TM_SELECTED_TEXT/(\\s*).*/$1/m}\\begin{${1:environment}}\n${TM_SELECTED_TEXT/(.+)|\\n\\z/(?1:\\t$0)/g}\n${TM_SELECTED_TEXT/(\\s*).*/$1/m}\\end{${1:environment}}\n",
  keyEquivalent: "^@W",
  name: "Environment — \\begin{}…\\end{}",
  scope: "text.tex.latex",
  uuid: "2D7B6866-400B-4120-9EC1-0397E33169A1"},
 {content: "\\begin{equation}\n\t$0\n\\end{equation}",
  name: "Equation",
  scope: "text.tex.latex",
  tabTrigger: "eq",
  uuid: "23B04BBB-ACE7-44A7-B313-09DC4874B2C0"},
 {content: "${1:Figure}~\\ref{${2:fig:}}$0",
  name: "Figure",
  scope: "text.tex.latex",
  tabTrigger: "figure",
  uuid: "C4288DF5-A4DA-4F35-9AB9-4062EE5B7E61"},
 {content: 
   "\\begin{gather`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}\n\t$0\n\\end{gather`echo $TM_SCOPE|grep math|\nsed -e 's/.*math.*/ed/'`}",
  name: "Gather(ed)",
  scope: "text.tex.latex",
  tabTrigger: "gat",
  uuid: "BE56EE31-7C87-43A6-B0ED-7E5C31432C1C"},
 {content: "\\\\begin{itemize}\n\t\\item $0\n\\\\end{itemize}",
  name: "Itemize",
  scope: "text.tex.latex",
  tabTrigger: "item",
  uuid: "CC9CC561-4BD2-4E50-A211-8C6141FFDE69"},
 {content: 
   "\\begin{${1:itemize}}\n${TM_SELECTED_TEXT/^(([^\\\\]*):\\s*)?(.+)$/\\n\\t\\item(?1: [ $2 ]) $3/g}\n\\end{${1:itemize}}\n",
  keyEquivalent: "^L",
  name: "Itemize Lines in Selection",
  scope: "text.tex.latex",
  uuid: "A7B97D14-AE83-11D9-8B45-000D93B6E43C"},
 {content: "${1:Listing}~\\ref{${2:lst:}}$0\n",
  name: "Listing",
  scope: "text.tex.latex",
  tabTrigger: "listing",
  uuid: "0F8A8F61-0AE1-44F8-B4FA-01D4F877E9EE"},
 {content: "\\( $TM_SELECTED_TEXT$1 \\)",
  keyEquivalent: "^M",
  name: "Math Mode — \\( … \\)",
  scope: "text.tex.latex",
  uuid: "445F9B97-7D25-4262-A715-03F9D688856A"},
 {content: 
   "\\begin{${1:p/b/v/V/B/small}matrix}\n\t$0\n\\end{${1:p/b/v/V/B/small}matrix}",
  name: "Matrix",
  scope: "text.tex.latex",
  tabTrigger: "mat",
  uuid: "66265AD6-3D2A-4888-9A9B-2B37860C79F3"},
 {content: "${1:page}~\\pageref{$2}$0\n",
  name: "Page",
  scope: "text.tex.latex",
  tabTrigger: "page",
  uuid: "FD59489B-7437-48DD-A4EC-9AF3AB2FCF19"},
 {content: 
   "\\paragraph{${1:paragraph name}} % (fold)\n\\label{par:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% paragraph $2 (end)",
  name: "Paragraph",
  scope: "text.tex.latex",
  tabTrigger: "par",
  uuid: "76987ABA-D716-4F75-ADC1-5FB767FC460E"},
 {content: 
   "\\part{${1:part name}} % (fold)\n\\label{prt:${2:${1/(\\w+)|\\W+/(?1:\\L$0:_)/g}}}\n${0:$TM_SELECTED_TEXT}\n% part $2 (end)",
  name: "Part",
  scope: "text.tex.latex",
  tabTrigger: "part",
  uuid: "A3F71E5B-C99E-488D-B1CB-39D588C28A8C"},
 {content: "${1:Section}~\\ref{${2:sec:}}$0\n",
  name: "Section",
  scope: "text.tex.latex",
  tabTrigger: "section",
  uuid: "5305AE18-1F7F-4284-A537-C0418119D078"},
 {content: 
   "\\section{${1:section name}} % (fold)\n\\label{sec:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% section $2 (end)",
  name: "Section",
  scope: "text.tex.latex",
  tabTrigger: "sec",
  uuid: "24282E70-BE2C-11D9-8F93-000D93589AF6"},
 {content: "\\begin{split}\n\t$0\n\\end{split}",
  name: "Split",
  scope: "text.tex.latex",
  tabTrigger: "spl",
  uuid: "66B38313-2239-430C-8DE9-95023BA583C2"},
 {content: 
   "\\subparagraph{${1:subparagraph name}} % (fold)\n\\label{subp:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% subparagraph $2 (end)",
  name: "Sub Paragraph",
  scope: "text.tex.latex",
  tabTrigger: "subp",
  uuid: "1475649F-2577-4BF0-A392-DD8D4B64DA91"},
 {content: 
   "\\subsection{${1:subsection name}} % (fold)\n\\label{sub:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% subsection $2 (end)",
  name: "Sub Section",
  scope: "text.tex.latex",
  tabTrigger: "sub",
  uuid: "4B41348F-BE2C-11D9-8F93-000D93589AF6"},
 {content: 
   "\\subsubsection{${1:subsubsection name}} % (fold)\n\\label{ssub:${2:${1/\\\\\\w+\\{(.*?)\\}|\\\\(.)|(\\w+)|([^\\w\\\\]+)/(?4:_:\\L$1$2$3)/g}}}\n${0:$TM_SELECTED_TEXT}\n% subsubsection $2 (end)",
  name: "Sub Sub Section",
  scope: "text.tex.latex",
  tabTrigger: "subs",
  uuid: "DF92968D-BF59-11D9-A668-000A95C0F626"},
 {content: "${1:Table}~\\ref{${2:tab:}}$0",
  name: "Table",
  scope: "text.tex.latex",
  tabTrigger: "table",
  uuid: "84216BD6-F6EB-4325-9485-1665E7364102"},
 {content: 
   "\\\\begin{${1:t}${1/(t)$|(a)$|(.*)/(?1:abular)(?2:rray)/}}{${2:c}}\n$0${2/((?<=.)c|l|r)|./(?1: & )/g}\n\\\\end{${1:t}${1/(t)$|(a)$|(.*)/(?1:abular)(?2:rray)/}}",
  name: "Tabular",
  scope: "text.tex.latex",
  tabTrigger: "tab",
  uuid: "0E817E24-DC11-42A5-BBBD-EEF1FD282B2F"},
 {content: "\\\\[\n\t$0\n\\\\]",
  keyEquivalent: "^[",
  name: "Unnumbered Equation",
  scope: "text.tex.latex",
  uuid: "7F7578B0-58F3-44B3-9278-1CBEA9C58208"},
 {content: 
   "\\\\begin{${1:env}}\n\t${1/(enumerate|itemize|list)|(description)|.*/(?1:\\item )(?2:\\item)/}$0\n\\\\end{${1:env}}",
  name: "\\begin{}…\\end{}",
  scope: "text.tex.latex",
  tabTrigger: "begin",
  uuid: "688FBE87-D5B4-445D-AD02-231F6E99F9C1"},
 {content: "\\\\item[${1:description}] ${0:item}",
  name: "\\item[description]",
  scope: "text.tex.latex meta.function.environment.list",
  tabTrigger: "itd",
  uuid: "BC8B98E2-5F16-11D9-B9C3-000D93589AF6"},
 {content: "${TM_SELECTED_TEXT/(.*)(.)/\\\\left$1\\\\right$2/}",
  keyEquivalent: "^L",
  name: "left…right — \\left…\\right",
  scope: "text.tex.latex",
  uuid: "2BCB6911-2FE8-4D28-9E9C-4AE5F54F6E72"}]
