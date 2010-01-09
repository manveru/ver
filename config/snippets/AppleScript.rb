# Encoding: UTF-8

{"choose" => 
  {scope: "source.applescript",
   name: "Item From List",
   content: 
    "set the_choice to choose from list ${1:{\"${2:choices}\"\\}}\n$0 "},
 "dialog" => 
  {scope: "source.applescript",
   name: "Text Field",
   content: 
    "set the_result to display dialog \"${1:text}\" ¬\n\tdefault answer \"${2:type here}\" ¬\n\t${3:with icon ${4:1} ¬\n\t}buttons {\"${6:Cancel}\", \"${5:OK}\"} ¬\n\tdefault button \"$5\"\nset button_pressed to button returned of the_result\nset text_typed to text returned of the_result\nif button_pressed is \"$5\" then\n\t${7:-- action for default button button goes here}\nelse\n\t-- action for cancel button goes here\nend if"},
 "alert" => 
  {scope: "source.applescript",
   name: "Display Alert",
   content: 
    "display alert \"${1:alert text}\" ¬\n\t${2:message \"${3:message text}\" ¬\n\t}${4:as warning}"},
 "shell" => 
  {scope: "source.applescript",
   name: "do shell script …",
   content: 
    "${1:set shell_stdout to }do shell script ${3:¬\n\t\"${2:#script}\"} ¬\n\twithout altering line endings\n$0"},
 "if" => 
  {scope: "source.applescript",
   name: "if … end",
   content: "if ${1:true} then\n\t${0:-- insert actions here}\nend if"},
 "on" => 
  {scope: "source.applescript",
   name: "on function … end",
   content: 
    "on ${1:functionName}(${2:arguments})\n\t${3:-- function actions}\nend $1"},
 "rep" => 
  {scope: "source.applescript",
   name: "repeat with ... in ...",
   content: "repeat with $1 in $2\n\t$0\nend repeat"},
 "tell" => 
  {scope: "source.applescript",
   name: "tell [app] … end",
   content: 
    "tell ${2:app \"${1:TextMate}\"}\n\t${0:-- insert actions here}\nend tell"},
 "try" => 
  {scope: "source.applescript",
   name: "try … on error … end",
   content: 
    "try\n\t${0:-- actions to try}\non error\n\t-- error handling\nend try"},
 "terms" => 
  {scope: "source.applescript",
   name: "using terms from [app] … end",
   content: 
    "using terms from ${1:app \"${2:Finder}\"}\n\t${0:-- insert actions here}\nend using terms from"},
 "timeout" => 
  {scope: "source.applescript",
   name: "with timeout … end",
   content: 
    "with timeout ${1:number} seconds\n\t${0:-- insert actions here}\nend timeout"},
 nil => 
  {scope: "source.applescript",
   name: "Split/Join Helper Functions",
   content: 
    "to split of aString by sep\n\tlocal aList, delims\n\ttell AppleScript\n\t\tset delims to text item delimiters\n\t\tset text item delimiters to sep\n\t\tset aList to text items of aString\n\t\tset  text item delimiters to delims\n\tend tell\n\treturn aList\nend split\n\nto join of aList by sep\n\tlocal aString, delims\n\ttell AppleScript\n\t\tset delims to text item delimiters\n\t\tset text item delimiters to sep\n\t\tset aString to aList as string\n\t\tset text item delimiters to delims\n\tend tell\n\treturn aString\nend join"},
 "delim" => 
  {scope: "source.applescript",
   name: "change text item delimiters",
   content: 
    "set oldDelims to AppleScript's text item delimiters\nset AppleScript's text item delimiters to {\"${1:,}\"}\n${0:-- insert actions here}\nset AppleScript's text item delimiters to oldDelims"},
 "con" => 
  {scope: "source.applescript",
   name: "considering … end considering",
   content: 
    "considering ${1:case}\n\t${0:-- insert actions here}\nend considering"},
 "ign" => 
  {scope: "source.applescript",
   name: "ignoring … end ignoring",
   content: 
    "ignoring ${1:application responses}\n\t${0:-- insert actions here}\nend ignoring"},
 "parent" => 
  {scope: "source.applescript",
   name: "prop parent …",
   content: "prop parent : app \"${1:TextMate}\""},
 "script" => 
  {scope: "source.applescript",
   name: "script … end",
   content: 
    "script ${1:new_object}\n\ton run\n\t\t${0:-- do something interesting}\n\tend run\nend script"}}
