# Encoding: UTF-8

{"ife" => 
  {scope: "source.perl",
   name: "Conditional if..else",
   content: "if ($1) {\n\t${2:# body...}\n} else {\n\t${3:# else...}\n}\n"},
 "ifee" => 
  {scope: "source.perl",
   name: "Conditional if..elsif..else",
   content: 
    "if ($1) {\n\t${2:# body...}\n} elsif ($3) {\n\t${4:# elsif...}\n} else {\n\t${5:# else...}\n}\n"},
 "xunless" => 
  {scope: "source.perl",
   name: "Conditional One-line",
   content: "${1:expression} unless ${2:condition};\n"},
 "xif" => 
  {scope: "source.perl",
   name: "Conditional One-line",
   content: "${1:expression} if ${2:condition};\n"},
 "sub" => 
  {scope: "source.perl",
   name: "Function",
   content: "sub ${1:function_name} {\n\t${2:# body...}\n}\n"},
 "xfore" => 
  {scope: "source.perl",
   name: "Loop One-line",
   content: "${1:expression} foreach @${2:array};\n"},
 "xwhile" => 
  {scope: "source.perl",
   name: "Loop One-line",
   content: "${1:expression} while ${2:condition};\n"},
 "class" => 
  {scope: "source.perl",
   name: "Package",
   content: 
    "package ${1:ClassName};\n\n${2:use base qw(${3:ParentClass});\n\n}sub new {\n\tmy \\$class = shift;\n\t\\$class = ref \\$class if ref \\$class;\n\tmy \\$self = bless {}, \\$class;\n\t\\$self;\n}\n\n1;\n"},
 "eval" => 
  {scope: "source.perl",
   name: "Try/Except",
   content: 
    "eval {\n\t${1:# do something risky...}\n};\nif (\\$@) {\n\t${2:# handle failure...}\n}\n"},
 "for" => 
  {scope: "source.perl",
   name: "Loop",
   content: 
    "for (my \\$${1:var} = 0; \\$$1 < ${2:expression}; \\$$1++) {\n\t${3:# body...}\n}\n"},
 "fore" => 
  {scope: "source.perl",
   name: "Loop",
   content: 
    "foreach ${1:my \\$${2:x}} (@${3:array}) {\n\t${4:# body...}\n}\n"},
 nil => {scope: "source.perl", name: "Hash Pointer", content: " => "},
 "if" => 
  {scope: "source.perl",
   name: "Conditional",
   content: "if ($1) {\n\t${2:# body...}\n}\n"},
 "slurp" => 
  {scope: "source.perl",
   name: "Read File",
   content: 
    "my \\$${1:var};\n{ local \\$/ = undef; local *FILE; open FILE, \"<${2:file}\"; \\$$1 = <FILE>; close FILE }\n"},
 "unless" => 
  {scope: "source.perl",
   name: "Conditional",
   content: "unless ($1) {\n\t${2:# body...}\n}\n"},
 "while" => 
  {scope: "source.perl",
   name: "Loop",
   content: "while ($1) {\n\t${2:# body...}\n}\n"},
 "test" => 
  {scope: "source.perl",
   name: "Test",
   content: 
    "#!/usr/bin/perl -w\n\nuse strict;\nuse Test::More tests => ${1:1};\nuse ${2:ModuleName};\n\nok(${3:assertion});\n"}}
