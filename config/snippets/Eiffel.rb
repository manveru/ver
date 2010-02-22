# Encoding: UTF-8

{"fd" => 
  {scope: "source.eiffel",
   name: "unique",
   content: "${1:constant}: ${2:TYPE} is unique"},
 "in" => 
  {scope: "source.eiffel",
   name: "if",
   content: 
    "if ${1:boolean_expression} then\n\t${2:instruction}${3:\nelseif\n\t${4:instruction}}${5:\nelse\n\t${6:instruction}}\nend"},
 "cl" => 
  {scope: "source.eiffel",
   name: "expanded class",
   content: 
    "-- ${1:class_name}\n\nexpanded class\n\t${1/(.*)/\\U$0\\E/}\ninherit\n\ncreate\n\nfeature\n\ninvariant\n\nend -- ${1/(.*)/\\U$0\\E/}\n"},
 "ix" => 
  {scope: "source.eiffel",
   name: "indexing",
   content: 
    "Indexing\n\tProject: \"$TM_FILEPATH\"\n\tFile: \"$TM_FILENAME\"\n\tDescription: \"${1:description}\"\n\tAuthor: \"${2:$USER}\"\n\tCopyright: \"© 2006 ${3:${TM_ORGANIZATION_NAME}}\"\n\tVersion: 1.0\n\tDate: \"`date`\"\n\tKeywords: ${4:keywords}\n"}}
