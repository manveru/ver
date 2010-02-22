# Encoding: UTF-8

{"w" => {scope: "source.ada", name: "with …;", content: "with $1;"},
 "ali" => {scope: "source.ada", name: "aliased", content: "aliased "},
 "acc" => {scope: "source.ada", name: "access", content: "access "},
 "loop" => 
  {scope: "source.ada",
   name: "loop … end loop",
   content: "loop\n\t$0\nend loop;"},
 "whi" => 
  {scope: "source.ada",
   name: "while … loop … end loop",
   content: "while $1 loop\n\t$0\nend loop;"},
 "eli" => 
  {scope: "source.ada", name: "elsif … then", content: "elsif $1 then\n\t$0"},
 "pro" => 
  {scope: "source.ada",
   name: "procedure … end",
   content: 
    "procedure ${1:Procedure} is\n\t$2\nbegin -- ${1/([a-zA-Z0-9_]*).*$/$1/}\n\t$0\nend ${1/([a-zA-Z0-9_]*).*$/$1/};"},
 "pac" => 
  {scope: "source.ada",
   name: "package … end",
   content: "package ${1:name} is\n\t$0\nend $1;"},
 "ty" => {scope: "source.ada", name: "type … is …", content: "type $1 is $0"},
 "fun" => 
  {scope: "source.ada",
   name: "function … end",
   content: 
    "function ${1:name} return $2 is\n\t$3\nbegin -- $1\n\t$0\nend $1;"},
 "wu" => 
  {scope: "source.ada",
   name: "with …; use …;",
   content: "with ${1}; use $1;\n$0"},
 "pne" => 
  {scope: "source.ada", name: "package … is …", content: "package $1 is $0"},
 "rec" => 
  {scope: "source.ada",
   name: "record … end record",
   content: "record\n\t$0\nend record;"},
 "ret" => {scope: "source.ada", name: "return …;", content: "return $1;"},
 "case" => 
  {scope: "source.ada",
   name: "case … is … end case;",
   content: "case $1 is\n\t$0\nend case;"},
 "beg" => 
  {scope: "source.ada", name: "begin … end", content: "begin\n\t$0\nend;"},
 "for" => 
  {scope: "source.ada",
   name: "for … loop … end loop",
   content: "for $1 in $2 loop\n\t$0\nend loop;"},
 "if" => 
  {scope: "source.ada",
   name: "if … end if",
   content: "if $1 then\n\t$0\nend if;"},
 "u" => {scope: "source.ada", name: "use …;", content: "use $1;"},
 "pbo" => 
  {scope: "source.ada",
   name: "package body … end",
   content: "package body ${1:name} is\n\t$0\nend $1;"},
 "when" => 
  {scope: "source.ada", name: "when … =>", content: "when $1 =>\n\t$0"}}
