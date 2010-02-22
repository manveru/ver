# Encoding: UTF-8

{"alert" => 
  {scope: "source.applescript",
   name: "Alert",
   content: 
    "display alert \"${1:alert text}\" ¬\n\t${2:message \"${3:message text}\" ¬\n\t}${4:as warning}"},
 "tell" => 
  {scope: "source.applescript",
   name: "tell [app] … end",
   content: 
    "tell ${1:application \"${2:Finder}\"}\n\t${0:-- statements}\nend tell"},
 "choose" => 
  {scope: "source.applescript",
   name: "Choose Color",
   content: 
    "${1:set the_color to }choose color default color ${2:{65536, 65536, 65536\\}}\n$0"},
 "rep" => 
  {scope: "source.applescript",
   name: "repeat while ... end",
   content: "repeat while ${1:condition}\n\t${0:-- statements}\nend repeat"},
 "dialog" => 
  {scope: "source.applescript",
   name: "OK/Cancel/Other",
   content: 
    "display dialog ${1:\"${2:text}\"}${3/.+/ ¬\n\twith icon /}${3:1} ¬\n\tbuttons {\"${5:Cancel}\", \"${6:Other}\", \"${4:OK}\"} ¬\n\tdefault button \"$4\"\nset button_pressed to button returned of result\nif button_pressed is \"$4\" then\n\t${7:-- statements for default button}${8/.+/\nelse if button_pressed is \"$5\" then\n\t/}${8:-- statements for cancel button}${9/.+/\nelse\n\t/}${9:-- statements for other button}\nend if\n"},
 "iff" => 
  {scope: "source.applescript",
   name: "if … then …",
   content: "if ${1:condition} then ${0:value}"},
 "dup" => 
  {scope: "source.applescript",
   name: "duplicate … to …",
   content: "duplicate ${1:value} to ${0:location}"},
 "timeout" => 
  {scope: "source.applescript",
   name: "with timeout … end",
   content: 
    "with timeout ${1:number} seconds\n\t${0:-- statements}\nend timeout"},
 "osa" => 
  {scope: "source.applescript",
   name: "#!/usr/bin/osascript",
   content: "#!/usr/bin/osascript"},
 nil => 
  {scope: "source.applescript",
   name: "Split/Join Helper Functions",
   content: 
    "to split of aString by sep\n\tlocal aList, delims\n\ttell AppleScript\n\t\tset delims to text item delimiters\n\t\tset text item delimiters to sep\n\t\tset aList to text items of aString\n\t\tset  text item delimiters to delims\n\tend tell\n\treturn aList\nend split\n\nto join of aList by sep\n\tlocal aString, delims\n\ttell AppleScript\n\t\tset delims to text item delimiters\n\t\tset text item delimiters to sep\n\t\tset aString to aList as string\n\t\tset text item delimiters to delims\n\tend tell\n\treturn aString\nend join"},
 "con" => 
  {scope: "source.applescript",
   name: "considering … end",
   content: "considering ${1:case}\n\t${0:-- statements}\nend considering"},
 "parent" => 
  {scope: "source.applescript",
   name: "prop parent …",
   content: "property parent : ${1:application \"${2:Finder}\"}"},
 "prop" => 
  {scope: "source.applescript",
   name: "prop …",
   content: "property ${1:prop_name} : ${0:value}"},
 "ign" => 
  {scope: "source.applescript",
   name: "ignoring … end",
   content: 
    "ignoring ${1:application responses}\n\t${0:-- statements}\nend ignoring"},
 "delim" => 
  {scope: "source.applescript",
   name: "change text item delimiters",
   content: 
    "set oldDelims to AppleScript's text item delimiters\nset AppleScript's text item delimiters to {\"${1:,}\"}\n${0:-- statements}\nset AppleScript's text item delimiters to oldDelims"},
 "try" => 
  {scope: "source.applescript",
   name: "try … on error … end",
   content: 
    "try\n\t${1:-- statements}\non error\n\t${2:-- error handling}\nend try"},
 "shell" => 
  {scope: "source.applescript",
   name: "do shell script …",
   content: 
    "${1/.+/set /}${1:shell_output}${1/.+/ to /}do shell script${2/.+/ ¬\n\t/}${2:\"${3:script}\"}${4/.+/ ¬\n\t/}${4:without altering line endings}\n"},
 "if" => 
  {scope: "source.applescript",
   name: "if … end",
   content: "if ${1:condition} then\n\t${0:-- statements}\nend if"},
 "transaction" => 
  {scope: "source.applescript",
   name: "with transaction … end",
   content: 
    "with transaction${1/.+/ /}${1:session}\n\t${0:-- statements}\nend transaction"},
 "set" => 
  {scope: "source.applescript",
   name: "set … to …",
   content: "set ${1:var_name} to ${0:value}"},
 "copy" => 
  {scope: "source.applescript",
   name: "copy … to …",
   content: "copy ${1:value} to ${0:location}"},
 "script" => 
  {scope: "source.applescript",
   name: "script … end",
   content: 
    "script ${1:script_object}\n\ton run\n\t\t${0:-- statements}\n\tend run\nend script"},
 "terms" => 
  {scope: "source.applescript",
   name: "using terms from [app] … end",
   content: 
    "using terms from ${1:application \"${2:Finder}\"}\n\t${0:-- statements}\nend using terms from"}}
