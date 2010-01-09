# Encoding: UTF-8

{nil => 
  {scope: "source.d comment.block",
   name: "Continue Block Comment",
   content: 
    "${TM_CURRENT_LINE/(.*\\*\\/$)|.*?(\\/\\*(?!.*\\*\\/)).*|.*/(?1:\n:\n(?2: )* )/}"},
 "class" => 
  {scope: "source.d",
   name: "class … { … }",
   content: 
    "class ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} {\n\tthis($2) {\n\t\t$0\n\t}\n}\n"},
 "ps" => 
  {scope: "source.d",
   name: "constant (private static final)",
   content: 
    "private static final ${1:char[]} ${2:name} = ${4:\"${3:value}\"};"},
 "debug" => 
  {scope: "source.d", name: "debug { … }", content: "debug {\n\t$0\n}"},
 "debugm" => 
  {scope: "source.d",
   name: "debug(module) { … }",
   content: "debug(${1:${TM_FILENAME/(.*?)(\\..+)/$1/}}) {\n\t$0\n}"},
 "en" => 
  {scope: "source.d",
   name: "enum … { … }",
   content: "enum ${1:name}() { $3 }"},
 "errf" => 
  {scope: "source.d",
   name: "Stderr(format, …)",
   content: "Stderr.format(\"${1:foo = {\\}}\", $2).newline;"},
 "err" => 
  {scope: "source.d", name: "Stderr(…)", content: "Stderr(\"$1\").newline;"},
 "fer" => 
  {scope: "source.d",
   name: "foreach_reverse(e; …) { … }",
   content: "foreach_reverse(${1:e}; $0) {\n\t\n}"},
 "fe" => 
  {scope: "source.d",
   name: "foreach(e; …) { … }",
   content: "foreach(${1:e}; $0) {\n\t\n}"},
 "ife" => 
  {scope: "source.d",
   name: "if … else",
   content: "if(${1:condition}) {\n\t$2\n}\nelse {\n\t$0\n}"},
 "if" => 
  {scope: "source.d", name: "if …", content: "if(${1:condition}) {\n\t$0\n}"},
 "im" => 
  {scope: "source.d",
   name: "import …",
   content: 
    "import ${1:${TM_FILEPATH/.+\\/([^\\/]+)\\/[^\\/]+\\.d$/\\l$1/}.};"},
 "loge" => 
  {scope: "source.d", name: "log.error(…)", content: "log.error(\"$1\");"},
 "logf" => 
  {scope: "source.d", name: "log.fatal(…)", content: "log.fatal(\"$1\");"},
 "log" => 
  {scope: "source.d", name: "log.info(…)", content: "log.info(\"$1\");"},
 "logt" => 
  {scope: "source.d", name: "log.trace(…)", content: "log.trace(\"$1\");"},
 "logw" => 
  {scope: "source.d", name: "log.warn(…)", content: "log.warn(\"$1\");"},
 "logger" => 
  {scope: "source.d",
   name: "Logger for Module",
   content: 
    "import tango.util.log.Log, tango.util.log.Configurator;\n\nprotected static Logger log = null;\nstatic this() {\n\tlog = Log.getLogger(${1:__FILE__});${2:\n\t//log.setLevel(log.Level.${3:Info});}\n}"},
 "maina" => 
  {scope: "source.d",
   name: "int main(char[][] args) { … }",
   content: "int main(char[][] args) {\n\t$1\n\treturn 0;\n}"},
 "main" => 
  {scope: "source.d",
   name: "void main() { … }",
   content: "void main() {\n\t${1}\n}"},
 "me" => 
  {scope: "source.d",
   name: "method … { … }",
   content: "/**\n * $2\n */\n${1:void} ${2:method}() {\n\t${3}\n}"},
 "outf" => 
  {scope: "source.d",
   name: "Stdout(format, …)",
   content: "Stdout.format(\"${1:foo = {\\}}\", $2).newline;"},
 "out" => 
  {scope: "source.d", name: "Stdout(…)", content: "Stdout(\"$1\").newline;"},
 "r" => {scope: "source.d", name: "return …", content: "return $0;"},
 "st" => 
  {scope: "source.d",
   name: "struct … { … }",
   content: "/**\n * $2\n */\nstruct ${1:name}() {\n\t$3\n}"},
 "tcf" => 
  {scope: "source.d",
   name: "try … catch … finally",
   content: 
    "try {\n\t$2\n} catch (${1:Exception} e) {\n\t$3\n} finally {\n\t$0\n}"},
 "tc" => 
  {scope: "source.d",
   name: "try … catch",
   content: "try {\n\t$2\n} catch (${1:Exception} e) {\n\t$0\n}"},
 "tf" => 
  {scope: "source.d",
   name: "try … finally",
   content: "try {\n\t$1\n} finally {\n\t$0\n}"},
 "unit" => 
  {scope: "source.d", name: "unittest { … }", content: "unittest {\n\t$0\n}"},
 "ver" => 
  {scope: "source.d",
   name: "version(ident) { … }",
   content: "version(${1:Posix}) {\n\t$0\n}"},
 "while" => 
  {scope: "source.d",
   name: "while(…) { … }",
   content: "while (${1:condition}) {\n\t$0\n}"}}
