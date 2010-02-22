# Encoding: UTF-8

{"case" => 
  {scope: "source.shell",
   name: "case … esac",
   content: "case ${1:word} in\n\t${2:pattern} )\n\t\t$0;;\nesac"},
 "until" => 
  {scope: "source.shell",
   name: "until … done",
   content: "until ${2:[[ ${1:condition} ]]}; do\n\t${0:#statements}\ndone"},
 "elif" => 
  {scope: "source.shell",
   name: "elif …",
   content: "elif ${2:[[ ${1:condition} ]]}; then\n\t${0:#statements}"},
 "while" => 
  {scope: "source.shell",
   name: "while … done",
   content: "while ${2:[[ ${1:condition} ]]}; do\n\t${0:#statements}\ndone"},
 "if" => 
  {scope: "source.shell",
   name: "if … fi",
   content: "if ${2:[[ ${1:condition} ]]}; then\n\t${0:#statements}\nfi"},
 "here" => 
  {scope: "source.shell",
   name: "Here Document",
   content: "<<-${2:'${1:TOKEN}'}\n\t$0\n${1/['\"`](.+)['\"`]/$1/}"},
 "for" => 
  {scope: "source.shell",
   name: "for … done",
   content: "for (( i = 0; i < ${1:10}; i++ )); do\n\t${0:#statements}\ndone"},
 "forin" => 
  {scope: "source.shell",
   name: "for … in … done",
   content: "for ${1:i}${2/.+/ in /}${2:words}; do\n\t${0:#statements}\ndone"},
 "!env" => 
  {scope: "",
   name: "#!/usr/bin/env",
   content: 
    "#!/usr/bin/env ${1:${TM_SCOPE/(?:source|.*)\\.(?:(shell)|(\\w+)).*/(?1:bash:$2)/}}\n"},
 "temp" => 
  {scope: "source.shell",
   name: "Tempfile",
   content: 
    "${1:TMPFILE}=\"$(mktemp -t ${2:`echo \"${TM_FILENAME%.*}\" | sed -e 's/[^a-zA-Z]/_/g' -e 's/^$/untitled/'`})\"\n${3:${4/(.+)/trap \"/}${4:rm -f '\\$${1/.*\\s//}'}${4/(.+)/\" 0               # EXIT\n/}${5/(.+)/trap \"/}${5:rm -f '\\$${1/.*\\s//}'; exit 1}${5/(.+)/\" 2       # INT\n/}${6/(.+)/trap \"/}${6:rm -f '\\$${1/.*\\s//}'; exit 1}${6/(.+)/\" 1 15    # HUP TERM\n/}}\n"}}
