# Encoding: UTF-8

{"in" => 
  {scope: "source.eiffel",
   name: "when",
   content: "when ${1:choice} then\n\t${2:instruction}"},
 "cl" => 
  {scope: "source.eiffel",
   name: "expanded class",
   content: 
    "-- ${1:class_name}\n\nexpanded class\n\t${1/(.*)/\\U$0\\E/}\ninherit\n\ncreate\n\nfeature\n\ninvariant\n\nend -- ${1/(.*)/\\U$0\\E/}\n"},
 "fd" => 
  {scope: "source.eiffel",
   name: "variable",
   content: "${1:constant}: ${2:TYPE}"},
 "ix" => 
  {scope: "source.eiffel",
   name: "indexing",
   content: 
    "Indexing\n\tProject: \"$TM_FILEPATH\"\n\tFile: \"$TM_FILENAME\"\n\tDescription: \"${1:description}\"\n\tAuthor: \"${2:$USER}\"\n\tCopyright: \"© 2006 ${3:${TM_ORGANIZATION_NAME}}\"\n\tVersion: 1.0\n\tDate: \"`date`\"\n\tKeywords: ${4:keywords}\n"}}
