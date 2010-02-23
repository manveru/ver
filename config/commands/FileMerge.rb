# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "#\n# $Id: FileMerge%20With%20Latest%20Revision%20(HEAD).plist 949 2006-04-21 18:02:26Z aparajita $\n#\n\nrequire_cmd \"${TM_SVN:=svn}\" \"If you have installed svn, then you need to either update your <tt>PATH</tt> or set the <tt>TM_SVN</tt> shell variable (e.g. in Preferences / Advanced)\"\n\nrequire_cmd opendiff \"You must install the Apple developer tools to run FileMerge.\"\n\n# See if the current file is under svn control\nFILE=`basename \"$TM_FILEPATH\"`\nINFO_LINES=`svn info \"$FILE\" 2>&1 | grep \"^Path\\: .*\\$\" | wc -l`\n\nif [ $INFO_LINES -eq 0 ]; then\n\techo \"The current file is not under subversion control\"\n\texit_show_tool_tip\nfi\n\n\"$TM_BUNDLE_SUPPORT/bin/filemerge.sh\" HEAD -\n",
  input: "none",
  keyEquivalent: "^@A",
  name: "Latest Revision (HEAD)",
  output: "discard",
  uuid: "BA930D7C-7B5E-4BFE-9293-6B8FAF962990"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#\n# $Id: FileMerge%20With%20Previous%20Revision%20(PREV).plist 949 2006-04-21 18:02:26Z aparajita $\n#\n\nrequire_cmd \"${TM_SVN:=svn}\" \"If you have installed svn, then you need to either update your <tt>PATH</tt> or set the <tt>TM_SVN</tt> shell variable (e.g. in Preferences / Advanced)\"\n\nrequire_cmd opendiff \"You must install the Apple developer tools to run FileMerge.\"\n\n# See if the current file is under svn control\nFILE=`basename \"$TM_FILEPATH\"`\nINFO_LINES=`svn info \"$FILE\" 2>&1 | grep \"^Path\\: .*\\$\" | wc -l`\n\nif [ $INFO_LINES -eq 0 ]; then\n\techo \"The current file is not under subversion control\"\n\texit_show_tool_tip\nfi\n\n\"$TM_BUNDLE_SUPPORT/bin/filemerge.sh\" PREV -\n",
  input: "none",
  keyEquivalent: "^@A",
  name: "Previous Revision (PREV)",
  output: "discard",
  uuid: "3FA49AEC-79AA-4E3A-BFDA-FD7E4EF8D0FE"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#\n# $Id: FileMerge%20With%20Revision....plist 949 2006-04-21 18:02:26Z aparajita $\n#\n\nrequire_cmd \"${TM_SVN:=svn}\" \"If you have installed svn, then you need to either update your <tt>PATH</tt> or set the <tt>TM_SVN</tt> shell variable (e.g. in Preferences / Advanced)\"\n\nrequire_cmd opendiff \"You must install the Apple developer tools to run FileMerge.\"\n\n# See if the current file is under svn control\nFILE=`basename \"$TM_FILEPATH\"`\nINFO_LINES=`svn info \"$FILE\" 2>&1 | grep \"^Path\\: .*\\$\" | wc -l`\n\nif [ $INFO_LINES -eq 0 ]; then\n\techo \"The current file is not under subversion control\"\n\texit_show_tool_tip\nfi\n\nrevs=$(\"$TM_SVN\" log -q \"$TM_FILEPATH\"|grep -v '^-*$' \\\n\t2> >(CocoaDialog progressbar --indeterminate \\\n\t\t--title \"Diff Revision…\" \\\n\t\t--text \"Retrieving List of Revisions…\" \\\n\t))\n\nrevs=`osascript<<END\n\tset AppleScript's text item delimiters to {\"\\n\",\"\\r\"}\n\ttell app \"SystemUIServer\"\n\t\tactivate\n\t\tset ourList to (every text item of \"$revs\")\n\t\tif the count of items in ourList is 0 then\n\t\t\tdisplay dialog \"No older revisions of file '$(basename \"$TM_FILEPATH\")' found\" buttons (\"OK\")\n\t\t\tset the result to false\n\t\telse\n\t\t\tchoose from list ourList with prompt \"Diff '$(basename \"$TM_FILEPATH\")' with older revision:\"\n\t\tend if\n\tend tell\nEND`\n\n# exit if user canceled\nif [[ $revs = \"false\" ]]; then\n\tosascript -e 'tell app \"TextMate\" to activate' &>/dev/null &\texit_discard\nfi\n\nREV=`echo \"$revs\" | tr '\\r' '\\n' | awk -F '|' '{ print substr($1, 2) }'`\n\"$TM_BUNDLE_SUPPORT/bin/filemerge.sh\" $REV -",
  input: "none",
  keyEquivalent: "^@A",
  name: "Revision...",
  output: "discard",
  uuid: "F0B1A94F-3FC5-47B8-8771-FFF4EF230156"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#\n# $Id: FileMerge%20Revisions....plist 949 2006-04-21 18:02:26Z aparajita $\n#\n\nrequire_cmd \"${TM_SVN:=svn}\" \"If you have installed svn, then you need to either update your <tt>PATH</tt> or set the <tt>TM_SVN</tt> shell variable (e.g. in Preferences / Advanced)\"\n\nrequire_cmd opendiff \"You must install the Apple developer tools to run FileMerge.\"\n\n# See if the current file is under svn control\nFILE=`basename \"$TM_FILEPATH\"`\nINFO_LINES=`svn info \"$FILE\" 2>&1 | grep \"^Path\\: .*\\$\" | wc -l`\n\nif [ $INFO_LINES -eq 0 ]; then\n\techo \"The current file is not under subversion control\"\n\texit_show_tool_tip\nfi\n\nrevs=$(\"$TM_SVN\" log -q \"$TM_FILEPATH\"|grep -v '^-*$' \\\n\t2> >(CocoaDialog progressbar --indeterminate \\\n\t\t--title \"Diff Revisions…\" \\\n\t\t--text \"Retrieving List of Revisions…\" \\\n\t))\n\nrevs=`osascript <<END\n\tset theResult to false\n\tset AppleScript's text item delimiters to {\"\\n\",\"\\r\"}\n\ttell app \"SystemUIServer\"\n\t\tactivate\n\t\tset ourList to (every text item of \"$revs\")\n\t\tif the count of items in ourList is 0 then\n\t\t\tdisplay dialog \"No revisions of file '$TM_FILENAME' found\" buttons (\"Continue\") default button 1\n\t\telse\n\t\t\ttell app \"SystemUIServer\" to choose from list (every text item of \"$revs\") with prompt \"Please choose two revisions of '$TM_FILENAME':\" with multiple selections allowed\n\n\t\t\tset theitems to the result\n\t\t\tif theitems is not false then\n\t\t\t\tif the count of items in the theitems is not 2 then\n\t\t\t\t\tdisplay dialog \"Please select exactly two revisions (hold down the Apple key to select multiple revisions).\" buttons (\"Continue\") default button 1\n\t\t\t\telse\n\t\t\t\t\tset theResult to (item 1 of theitems) & return & (item 2 of theitems)\n\t\t\t\tend if\n\t\t\tend if \n\t\tend if\n\t\tset the result to theResult\n\tend tell\nEND`\n\n# exit if user canceled\nif [[ $revs = \"false\" ]]; then\n\tosascript -e 'tell app \"TextMate\" to activate' &>/dev/null &\texit_discard\nfi\n\nrevs=`echo -n \"$revs\" | awk -F '|' 'BEGIN { RS=\"\\r\"} { print substr($1, 2) }'`\nrevs=( $revs )\n\"$TM_BUNDLE_SUPPORT/bin/filemerge.sh\" ${revs[1]} ${revs[0]}\n",
  input: "none",
  keyEquivalent: "^@A",
  name: "Revisions...",
  output: "discard",
  uuid: "9029E141-4526-4ED8-95B2-2A4E19BAD402"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#\n# $Id: FileMerge%20With%20Working%20Copy%20(BASE).plist 949 2006-04-21 18:02:26Z aparajita $\n#\n\nrequire_cmd \"${TM_SVN:=svn}\" \"If you have installed svn, then you need to either update your <tt>PATH</tt> or set the <tt>TM_SVN</tt> shell variable (e.g. in Preferences / Advanced)\"\n\nrequire_cmd opendiff \"You must install the Apple developer tools to run FileMerge.\"\n\n# See if the current file is under svn control\nFILE=`basename \"$TM_FILEPATH\"`\nINFO_LINES=`svn info \"$FILE\" 2>&1 | grep \"^Path\\: .*\\$\" | wc -l`\n\nif [ $INFO_LINES -eq 0 ]; then\n\techo \"The current file is not under subversion control\"\n\texit_show_tool_tip\nfi\n\n\"$TM_BUNDLE_SUPPORT/bin/filemerge.sh\" BASE -\n",
  input: "none",
  keyEquivalent: "^@A",
  name: "Working Copy (BASE)",
  output: "discard",
  uuid: "9F8B60D0-0535-4B92-8A02-A5AF47BE5306"}]
