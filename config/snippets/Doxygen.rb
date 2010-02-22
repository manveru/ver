# Encoding: UTF-8

{"dxf" => 
  {scope: "source.objc, source.objc++, source.c, source.c++",
   name: "Function",
   content: 
    "/** \\brief ${4:undocumented function}\n\t${5:\n\t\tlonger description\n\t}\n\t\\author ${TM_AUTHOR:$TM_FULLNAME} $TM_ORGANIZATION_NAME\n\t\\date `date +%Y-%m-%d`\n\t\\param $2 ${3:description of parameter}\n\t${7:\\param $8 ${9:description of parameter}}$0\n\t\\return ${6:description of return value}\n\t\\sa\n**/"},
 "dxg" => 
  {scope: "source.php",
   name: "Group",
   content: 
    "/** \\name ${1:nameOfGroup} ${2\n${3:description}\n}**/\n//@{\n$TM_SELECTED_TEXT\n//@}"},
 "dxv" => 
  {scope: "source.php",
   name: "Class Variable",
   content: "${1:var} ${2:var}; //!< ${3:undocumented class variable}\n"},
 "dxp" => 
  {scope: "text.html.basic",
   name: "Page Template",
   content: 
    "<?php\n/** \\page $TM_FILEPATH ${1:A documentation page}\n\t${2:longer description}\n© Copyright `date +%Y` $TM_ORGANIZATION_NAME - ${TM_AUTHOR:$TM_FULLNAME}. All Rights Reserved.\n\t\\author ${TM_AUTHOR:$TM_FULLNAME} $TM_ORGANIZATION_NAME\n\t\\author \\$LastChangedBy\\$\n\t\\date `date +%Y-%m-%d`\n\t\\date \\$LastChangedDate\\$\n\t\\version \\$Rev\\$\n**/\n?>"},
 "dxc" => 
  {scope: "source.php",
   name: "Class PHP doc only",
   content: 
    "/** \\brief  ${3:undocumented class}\n\t\n\t${4:undocumented class}\n\t\n&copy; Copyright `date +%Y` `echo $TM_ORGANIZATION_NAME` - `echo $TM_AUTHOR`. All Rights Reserved.\n\n\t\\\\author `echo $TM_AUTHOR` `echo $TM_ORGANIZATION_NAME`\n\t\\\\author \\$LastChangedBy\\$\n\t\\\\date `TZ=GMT date +%Y-%m-%d # T%H:%M:%SZ`\n\t\\\\date \\$LastChangedDate\\$\n\t\\\\version \\$Rev\\$\n\t\\sa\n**/\n"},
 "dxpu" => 
  {scope: "source.php",
   name: "Public Section",
   content: "/*! \\publicsection */"},
 "dxpr" => 
  {scope: "source.php",
   name: "Private Section",
   content: "/*! \\privatesection */"},
 "/*!" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "/*! … */",
   content: "/*!\n * $0\n */"},
 "/**" => 
  {scope: "source.c, source.objc, source.c++, source.objc++",
   name: "/** … */",
   content: "/**\n * $0\n**/"}}
