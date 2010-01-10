# Encoding: UTF-8

{"rug" => 
  {scope: "source.r, source.rd.console",
   name: "Add Tick Marks",
   content: "rug(${1:jitter(${2:x})})"},
 "att" => 
  {scope: "source.r, source.rd.console",
   name: "Attach",
   content: "attach(${1:frame})"},
 "cum" => 
  {scope: "source.r, source.rd.console",
   name: "Cummulative",
   content: "cum${1:max}(${2:x})"},
 "den" => 
  {scope: "source.r, source.rd.console",
   name: "Density",
   content: "density(${1:x}${2:, bw = ${3:bandwidth}})"},
 "det" => 
  {scope: "source.r, source.rd.console",
   name: "Detach",
   content: "detach(${0:})"},
 "cut" => 
  {scope: "source.r, source.rd.console",
   name: "Divide Into Intervals",
   content: "cut(${1:x}, breaks = c(${2:${3:}, ${4:max(${1:x})}}))"},
 "fac" => 
  {scope: "source.r, source.rd.console",
   name: "Factor",
   content: "factor(${1:x})"},
 "for" => 
  {scope: "source.r, source.rd.console",
   name: "For Loop",
   content: "for (${1:i} in ${2:seq}) ${3:{$0\\}}"},
 "fun" => 
  {scope: "source.r, source.rd.console",
   name: "Function",
   content: "function(${1:x}) ${3:{$0\\}}"},
 "ife" => 
  {scope: "source.r, source.rd.console",
   name: "Ifelse",
   content: "ifelse(${1:test}, ${2:yes}, ${3:no})"},
 "len" => 
  {scope: "source.r, source.rd.console",
   name: "Length",
   content: "length(${1:x})"},
 "dat" => 
  {scope: "source.r, source.rd.console",
   name: "Load Dataset",
   content: "data(${1:name})"},
 "lin" => 
  {scope: "source.r, source.rd.console",
   name: "Polygonal Line",
   content: "lines(${1:x}${2:, color=${3:red}})"},
 "rea" => 
  {scope: "source.r, source.rd.console",
   name: "Read From File",
   content: 
    "read.table(\"${1:filename}\"${2:, header = ${3:TRUE},  sep = \"${4:\\t}\",  stringsAsFactors = ${5:FALSE}})"},
 "seq" => 
  {scope: "source.r, source.rd.console",
   name: "Sequence (from,to,by)",
   content: "seq(${1:from}, ${2:to}, ${3:by})"},
 "sor" => 
  {scope: "source.r, source.rd.console",
   name: "Sort",
   content: "sort(${1:x})"},
 "sou" => 
  {scope: "source.r, source.rd.console",
   name: "Source",
   content: "source(${1:\"${2:}\"}${3:, chdir = ${4:TRUE}})"},
 "fch" => 
  {scope: "source.r, source.rd.console",
   name: "file.choose",
   content: "${1:file = }file.choose()${0:}"},
 "nao" => 
  {scope: "source.r, source.rd.console",
   name: "na.omit",
   content: "na.omit(${0:})"}}
