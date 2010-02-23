# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "#!/usr/bin/env bash\nSCRIPT_PATH=\"Library/Application Support/Textmate/Widget Scripts\"\nESCAPED_FILEPATH=$(echo $TM_FILEPATH | sed -e 's/\\\"/\\\\\\\"/g' -e 's/\\`/\\\\\\`/g')\nmkdir -p ~/\"$SCRIPT_PATH\"\necho \\#\\!\\/usr/bin/env bash > ~/\"$SCRIPT_PATH/default.sh\"\necho -n \"\\\"$ESCAPED_FILEPATH\\\" \\\"\\$@\\\"\" >> ~/\"$SCRIPT_PATH/default.sh\"\necho -n \"\\\"$TM_FILENAME\\\"\" > ~/\"$SCRIPT_PATH/filename.txt\"\n\"$TM_BUNDLE_SUPPORT/deploy_widget.sh\"\necho \"Widget created.\"\n",
  input: "none",
  name: "Create Widget Calling Current Document",
  output: "showAsTooltip",
  uuid: "61B9EE59-3C49-45B8-94DE-7C0C8BCB965C"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env bash\nSCRIPT_PATH=\"Library/Application Support/Textmate/Widget Scripts\"\nmkdir -p ~/\"$SCRIPT_PATH\"\ncat > ~/\"$SCRIPT_PATH/default.sh\"\n\"$TM_BUNDLE_SUPPORT/deploy_widget.sh\"\necho \"Widget created.\"\n",
  input: "document",
  name: "Create Widget With Contents of Document",
  output: "showAsTooltip",
  uuid: "907BF622-2B0E-43C7-85F6-369A67226CA4"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\n\nhtml_header \"Widget Creator Bundle Help\" \"Widget Creator\"\n\nMarkdown.pl <<\"EOF\"|SmartyPants.pl\n\n## Widget Creator Bundle Help\n\nThe Widget Creator Bundle provides an interface to scripts normally accessed through Terminal.app through the Dashboard layer of OS X.\n\nThe bundle includes a Dashboard widget, which will be installed automatically when the command \"*Create Widget With Contents of Document*\" or \"*Create Widget Calling Current Document*\" are called within Textmate.\n\n### \"Create Widget With Contents of Document\"\n\nWhen editing a script which would usually be executed in a shell terminal such as Terminal.app, calling the \"*Create Widget With Contents of Document*\" command will copy the contents of the current document to a new file created in ~/Application Settings/Textmate/Widget Scripts/ and a new instance of a widget will appear on the Dashboard layer of OS X.\n\nWhen this widget is clicked on the copied script will run, and any output to STDOUT or STDERR will be accessable by clicking on the green or red icons which should appear on the widget respectively.\n\nAddtionally, if any files or a URL is dragged on to the widget then arguments are passed to the script with either the full path and filename of each file, or the URL itself.\n\n### \"Create Widget Calling Current Document\"\n\nIf the \"*Create Widget Calling Current Document*\" command is invoked in Textmate whilst editing a saved script, then a new widget is created which will call the already existing script, passing any arguments in the process (i.e. any files/URL dropped).\n\nThis is useful feature if you plan on calling the script used by the widget in a shell terminal as well as through Dashboard, so any changes you make to the original script are also reflected when called by both methods.\n\n### \"Insert Loop to Handle Multiple Arguments\"\n\nThe only snippet in this bundle will allow a bash script to deal with multiple arguments, this is useful when applying the same action to multiple files when they are dragged on to the widget.\n\nWhen the snippet is inserted a loop will appear in the edit window, and any commands nested within the loop with be performed as many times as there are arguments (i.e. files) passed to the script. Each time the loop iterates a new argument will be assigned to $ARG, so for example 'rm \"$arg\"' within the loop will delete every file dragged on to the widget.\n\n### Hints\n\nThis document can be printed using *Print…* (⌘P) from the *File* menu.\nEOF\n\nhtml_footer\n",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  uuid: "A0F5745D-6DC1-4D2B-B638-8A38AB18EE68"}]
