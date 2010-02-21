# Encoding: UTF-8

{"throw" => 
  {scope: "source.php",
   name: "Throw Exception",
   content: 
    "throw new $1Exception(${2:\"${3:Error Processing Request}\"}${4:, ${5:1}});\n$0"},
 "if" => 
  {scope: "source.php",
   name: "if …",
   content: "if (${1:condition}) {\n\t${0:# code...}\n}"},
 "ifelse" => 
  {scope: "text.html",
   name: "<?php if (…) ?> … <?php else ?> … <?php endif ?>",
   content: 
    "<?${TM_PHP_OPEN_TAG:php} if (${1:condition}): ?>\n\t$2\n<?${TM_PHP_OPEN_TAG:php} else: ?>\n\t$0\n<?${TM_PHP_OPEN_TAG:php} endif ?>"},
 "<<<" => 
  {scope: "source.php",
   name: "Heredoc",
   content: "<<<${1:HTML}\n${2:content here}\n$1;\n"},
 "fun" => 
  {scope: "source.php",
   name: "function …",
   content: 
    "${1:public }function ${2:FunctionName}(${3:\\$${4:value}${5:=''}})\n{\n\t${0:# code...}\n}"},
 "incl" => 
  {scope: "source.php", name: "include …", content: "include '${1:file}';$0"},
 "$_" => 
  {scope: "source.php",
   name: "SESSION['…']",
   content: "\\$_SESSION['${1:variable}']"},
 "elseif" => 
  {scope: "source.php",
   name: "elseif …",
   content: "elseif (${1:condition}) {\n\t${0:# code...}\n}"},
 "do" => 
  {scope: "source.php",
   name: "do … while …",
   content: "do {\n\t${0:# code...}\n} while (${1:$a <= 10});"},
 "doc_f" => 
  {scope: "source.php",
   name: "Function",
   content: 
    "/**\n * ${4:undocumented function}\n *\n * @return ${5:void}\n * @author ${PHPDOC_AUTHOR:$TM_FULLNAME}$6\n **/\n$1function $2($3)\n{$0\n}"},
 "foreach" => 
  {scope: "text.html",
   name: "<?php foreach (…) … <?php endforeach ?>",
   content: 
    "<?${TM_PHP_OPEN_TAG:php} foreach (\\$${1:variable} as \\$${2:key}${3: => \\$${4:value}}): ?>\n\t${0}\n<?${TM_PHP_OPEN_TAG:php} endforeach ?>"},
 "req" => 
  {scope: "source.php", name: "require …", content: "require '${1:file}';$0"},
 "con" => 
  {scope: "source.php",
   name: "function __construct",
   content: 
    "function __construct(${1:\\$${2:foo}${3: = ${4:null}}}) {\n\t${2/.+/$this->$0 = \\$$0;/}$0\n}"},
 "case" => 
  {scope: "source.php",
   name: "case …",
   content: "case '${1:variable}':\n\t${0:# code...}\n\tbreak;"},
 "class" => 
  {scope: "source.php",
   name: "class …",
   content: 
    "/**\n* $1\n*/\nclass ${2:ClassName}${3: extends ${4:AnotherClass}}\n{\n\t$5\n\tfunction ${6:__construct}(${7:argument})\n\t{\n\t\t${0:# code...}\n\t}\n}\n"},
 "ret1" => 
  {scope: "source.php", name: "return true", content: "return true;$0"},
 "array" => 
  {scope: "source.php",
   name: "$… = array (…)",
   content: "\\$${1:arrayName} = array('$2' => $3${4:,} $0);"},
 "def?" => 
  {scope: "source.php", name: "defined(…)", content: "$1defined('$2')$0"},
 "doc_h" => 
  {scope: "source.php",
   name: "Header",
   content: 
    "/**\n * $1\n *\n * @author ${PHPDOC_AUTHOR:$TM_FULLNAME}\n * @version \\$Id\\$\n * @copyright `echo $TM_ORGANIZATION_NAME`, `date +\"%e %B, %Y\" | sed 's/^ //'`\n * @package ${3:default}\n **/\n\n/**\n * Define DocBlock\n **/\n"},
 "ret" => {scope: "source.php", name: "return", content: "return$1;$0"},
 "doc_v" => 
  {scope: "source.php",
   name: "Class Variable",
   content: 
    "/**\n * ${3:undocumented class variable}\n *\n * @var ${4:string}\n **/\n${1:var} \\$$2;$0"},
 "/**" => 
  {scope: "source.php", name: "Start Docblock", content: "/**\n * $0\n */"},
 "php" => 
  {scope: "source.php",
   name: "?>…<?php",
   content: "?>$0<?${TM_PHP_OPEN_TAG:php}"},
 "globals" => 
  {scope: "source.php",
   name: "$GLOBALS['…']",
   content: "\\$GLOBALS['${1:variable}']${2: = }${3:something}${4:;}$0"},
 "req1" => 
  {scope: "source.php",
   name: "require_once …",
   content: "require_once '${1:file}';$0"},
 "for" => 
  {scope: "source.php",
   name: "for …",
   content: 
    "for (\\$${1:i}=${2:0}; \\$${1:i} < $3; \\$${1:i}++) { \n\t${0:# code...}\n}"},
 "doc_i" => 
  {scope: "source.php",
   name: "Interface",
   content: 
    "/**\n * ${2:undocumented class}\n *\n * @package ${3:default}\n * @author ${PHPDOC_AUTHOR:$TM_FULLNAME}\n **/\ninterface $1\n{$0\n} // END interface $1"},
 "ethis" => 
  {scope: "text.html - source",
   name: "<?php echo $this->… ?>",
   content: "<?${TM_PHP_OPEN_TAG_WITH_ECHO:php echo} \\$this->$0 ?>"},
 "doc_s" => 
  {scope: "source.php",
   name: "Function Signature",
   content: 
    "/**\n * ${4:undocumented function}\n *\n * @return ${5:void}\n * @author ${PHPDOC_AUTHOR:$TM_FULLNAME}$6\n **/\n$1function $2($3);$0"},
 "incl1" => 
  {scope: "source.php",
   name: "include_once …",
   content: "include_once '${1:file}';$0"},
 "tmphp" => 
  {scope: "source.php",
   name: "Include TextMate Support Script",
   content: 
    "// === TextMate error handling ===\n`if [[ \"$TM_BUNDLE_SUPPORT\" == \"$HOME\"* ]]; then\n  echo \"// NOTE: Your PHP bundle is checked out to your home directory.\"\n  echo \"// If the webserver process does not have permission to access\"\n  echo \"// the included file, you can replace\"\n  echo \"// ‘${TM_BUNDLE_SUPPORT%Bundles*}’ with\"\n  echo \"// ‘$(find_app TextMate.app)/Contents/SharedSupport/’.\"\nfi`\n@include_once '$TM_BUNDLE_SUPPORT/textmate.php';\n"},
 nil => 
  {scope: "source.php comment.block",
   name: "Continue Block Comment",
   content: 
    "${TM_CURRENT_LINE/(.*\\*\\/$)|.*?(\\/\\*(?!.*\\*\\/)).*|.*/(?1:\n:\n(?2: )* )/}"},
 "ret0" => 
  {scope: "source.php", name: "return false", content: "return false;$0"},
 "switch" => 
  {scope: "source.php",
   name: "switch …",
   content: 
    "switch (${1:variable}) {\n\tcase '${2:value}':\n\t\t${3:# code...}\n\t\tbreak;\n\t$0\n\tdefault:\n\t\t${4:# code...}\n\t\tbreak;\n}"},
 "echoh" => 
  {scope: "text.html",
   name: "<?php echo htmlentities(…) ?>",
   content: 
    "<?${TM_PHP_OPEN_TAG_WITH_ECHO:php echo} htmlentities(${1:\\$var}, ENT_QUOTES, 'utf-8') ?>$0"},
 "this" => 
  {scope: "text.html - source",
   name: "<?php $this->… ?>",
   content: "<?${TM_PHP_OPEN_TAG:php} \\$this->$0 ?>"},
 "try" => 
  {scope: "source.php",
   name: "Wrap in try { … } catch (…) { … }",
   content: 
    "${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}try {\n\t${3:${TM_SELECTED_TEXT/(\\A.*)|(.+)|\\n\\z/(?1:$0:(?2:\\t$0))/g}}\n${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}} catch (${1:Exception} ${2:\\$e}) {\n${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}\t$0\n${TM_SELECTED_TEXT/([\\t ]*).*/$1/m}}"},
 "while" => 
  {scope: "source.php",
   name: "while …",
   content: "while (${1:$a <= 10}) {\n\t${0:# code...}\n}"},
 "else" => 
  {scope: "source.php",
   name: "else …",
   content: "else {\n\t${0:# code...}\n}"},
 "echo" => 
  {scope: "source.php",
   name: "echo \"…\"",
   content: "echo \"${1:string}\"${0};"},
 "phperr" => 
  {scope: "text.html",
   name: "PHP Error Catching JavaScript",
   content: 
    "`cat \"$TM_BUNDLE_SUPPORT/textmate_error_handler.html\" | grep -E -v '^[ \\t\\s]*\\/\\/' | sed 's/\\(.*\\)[ \\t]*--.*/\\1/' | tr -s ' \\n\\t' ' ' | sed 's/.\\{80\\}[{};]/&\\\n/g'`"},
 "doc_c" => 
  {scope: "source.php",
   name: "Class",
   content: 
    "/**\n * ${3:undocumented class}\n *\n * @package ${4:default}\n * @author ${PHPDOC_AUTHOR:$TM_FULLNAME}\n **/\n$1class $2\n{$0\n} // END $1class $2"},
 "if?" => 
  {scope: "source.php",
   name: "$… = ( … ) ? … : …",
   content: "\\$${1:retVal} = (${2:condition}) ? ${3:a} : ${4:b} ;"},
 "doc_d" => 
  {scope: "source.php",
   name: "Constant Definition",
   content: "/**\n * ${3:undocumented constant}\n **/\ndefine($1, $2);$0"},
 "def" => 
  {scope: "source.php",
   name: "define(…, …)",
   content: "define('$1', ${2:'$3'});\n$0"}}
