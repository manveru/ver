# Encoding: UTF-8

[{content: 
   "\\header {\n\ttitle = \"${1:Title}\"\n\tinstrument = \"${2:Instrument}\"\n\tcomposer = \"${3:Composer}\"\n\tdate = \"${4:Date}\"\n}",
  name: "header",
  scope: "source.lilypond",
  tabTrigger: "head",
  uuid: "6F8F1607-8D59-4E4D-94D1-7565B4921B81"},
 {content: "\\relative${1/(\\S)?.*/(?1: )/}${1:c''} {$0}",
  name: "relative",
  scope: "source.lilypond",
  tabTrigger: "rel",
  uuid: "C54C69BF-701D-445E-A433-102BEFCE20C7"},
 {content: 
   "\\repeat \"${1:volta}\" ${2:2} {\n\t$3\n}\n${1/(volta)|(.*)/(?1:\\\\alternative {\\n\\t{  }\\n\\t{  }\\n})(?2:)/}",
  name: "repeat",
  scope: "source.lilypond",
  tabTrigger: "rep",
  uuid: "73B33ED5-1704-47C6-B397-034B27A38433"},
 {content: "\\times $1/$2 { $3 }",
  name: "times",
  scope: "source.lilypond",
  tabTrigger: "times",
  uuid: "A94FA5D8-1C91-474F-A98D-AFFC42D39BBA"}]
