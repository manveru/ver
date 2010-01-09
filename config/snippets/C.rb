# Encoding: UTF-8

{nil => 
  {scope: 
    "source.c, source.c++, source.objc, source.objc++, (source.c | source.c++ | source.objc | source.objc++) & comment.block.preprocessor",
   name: "#endif",
   content: "#endif\n"},
 "inc" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "#include \"…\"",
   content: "#include \"${1:${TM_FILENAME/\\..+$/.h/}}\""},
 "Inc" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "#include <…>",
   content: "#include <${1:.h}>"},
 "mark" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "#pragma mark",
   content: "#if 0\n${1:#pragma mark -\n}#pragma mark $2\n#endif\n\n$0"},
 "beginend" => 
  {scope: "source.c++, source.objc++",
   name: "$1.begin(), $1.end()",
   content: 
    "${1:v}${1/^.*?(-)?(>)?$/(?2::(?1:>:.))/}begin(), ${1:v}${1/^.*?(-)?(>)?$/(?2::(?1:>:.))/}end()"},
 "main" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "main()",
   content: 
    "int main (int argc, char const${TM_C_POINTER: *}argv[])\n{\n\t${0:/* code */}\n\treturn 0;\n}"},
 "for" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "For Loop",
   content: 
    "for(size_t ${2:i} = 0; $2 < ${1:count}; ${3:++$2})\n{\n\t${0:/* code */}\n}"},
 "once" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "Header Include-Guard",
   content: 
    "#ifndef ${1:`#!/usr/bin/env ruby -wKU -riconv\nname = ENV[\"TM_FILENAME\"] || \"untitled\"\nname = Iconv.iconv(\"ASCII//TRANSLIT\", \"UTF-8\", name).first\nname = name.gsub(/[^a-z0-9]+/i, \"_\")\nuuid = (rand * 2821109907455).round.to_s(36)\nprint \"\#{name}_\#{uuid}\".tr(\"[a-z]\", \"[A-Z]\")\n`}\n#define $1\n\n${TM_SELECTED_TEXT/\\Z\\n//}${0:}\n\n#endif /* end of include guard: $1 */\n"},
 "cl" => 
  {scope: "source.c++, source.objc++",
   name: "Class",
   content: 
    "class ${1:${TM_FILENAME/(.+)\\..+|.*/(?1:\\L$1_t:name)/}}\n{\npublic:\n\t${1/(\\w+).*/$1/} (${2:arguments});\n\tvirtual ~${1/(\\w+).*/$1/} ();\n\nprivate:\n\t${0:/* data */}\n};"},
 "do" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "Do While Loop",
   content: "do {\n\t${0:/* code */}\n} while(${1:/* condition */});"},
 "if" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "If Condition",
   content: "if(${1:/* condition */})\n{\n\t${0:/* code */}\n}"},
 "ns" => 
  {scope: "source.c++, source.objc++",
   name: "Namespace",
   content: 
    "namespace${1/.+/ /m}${1:${TM_FILENAME/^((.*?)\\..*)?$/(?1:\\L$2:my)/}}\n{\n\t$0\n}${1/.+/ \\/* /m}$1${1/.+/ *\\/ /m}"},
 "printf" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "printf …",
   content: 
    "printf(\"${1:%s}\\\\n\"${1/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$2${1/([^%]|%%)*(%.)?.*/(?2:\\);)/}"},
 "readfile" => 
  {scope: "source.c++, source.objc++",
   name: "Read File Into Vector",
   content: 
    "std::vector<char> v;\nif(FILE${TM_C_POINTER: *}fp = fopen(${1:\"filename\"}, \"r\"))\n{\n\tchar buf[1024];\n\twhile(size_t len = fread(buf, 1, sizeof(buf), fp))\n\t\tv.insert(v.end(), buf, buf + len);\n\tfclose(fp);\n}"},
 "map" => 
  {scope: "source.c++, source.objc++",
   name: "std::map",
   content: "std::map<${1:key}, ${2:value}> map$0;"},
 "vector" => 
  {scope: "source.c++, source.objc++",
   name: "std::vector",
   content: "std::vector<${1:char}> v$0;"},
 "st" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "Struct",
   content: 
    "struct ${1:${TM_FILENAME/(.+)\\..+|.*/(?1:\\L$1_t:name)/}}\n{\n\t${0:/* data */}\n};"},
 "tp" => 
  {scope: "source.c++, source.objc++",
   name: "template <typename …>",
   content: "template <typename ${1:_InputIter}>"},
 "def" => 
  {scope: "source.c, source.c++, source.objc, source.objc++",
   name: "#ifndef … #define … #endif",
   content: 
    "#ifndef ${1/([A-Za-z0-9_]+).*/$1/}\n#define ${1:SYMBOL} ${2:value}\n#endif"},
 "enum" => 
  {scope: "source.c++, source.objc++",
   name: "Enumeration",
   content: "enum ${1:name} { $0 };"},
 "td" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "Typedef",
   content: "typedef ${1:int} ${2:MyCustomType};"},
 "fprintf" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "fprintf …",
   content: 
    "fprintf(${1:stderr}, \"${2:%s}\\\\n\"${2/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$3${2/([^%]|%%)*(%.)?.*/(?2:\\);)/}"}}
