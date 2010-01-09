# Encoding: UTF-8

{"head" => 
  {scope: "source.lilypond",
   name: "header",
   content: 
    "\\header {\n\ttitle = \"${1:Title}\"\n\tinstrument = \"${2:Instrument}\"\n\tcomposer = \"${3:Composer}\"\n\tdate = \"${4:Date}\"\n}"},
 "rel" => 
  {scope: "source.lilypond",
   name: "relative",
   content: "\\relative${1/(\\S)?.*/(?1: )/}${1:c''} {$0}"},
 "rep" => 
  {scope: "source.lilypond",
   name: "repeat",
   content: 
    "\\repeat \"${1:volta}\" ${2:2} {\n\t$3\n}\n${1/(volta)|(.*)/(?1:\\\\alternative {\\n\\t{  }\\n\\t{  }\\n})(?2:)/}"},
 "times" => 
  {scope: "source.lilypond", name: "times", content: "\\times $1/$2 { $3 }"}}
