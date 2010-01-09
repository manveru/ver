# Encoding: UTF-8

{nil => 
  {scope: "source.shell",
   name: "Insert Loop to Handle Multiple Arguments",
   content: 
    "for arg in \"\\$@\"\ndo\n\t#Treat each file dropped on to the widget as \"\\$arg\" in this loop\n\t${0:$TM_SELECTED_TEXT}\ndone\n"}}
