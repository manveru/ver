# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: "cat \"${TM_BUNDLE_PATH}/README.html\"",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  scope: "source.pascal",
  uuid: "AAAB7E78-7F66-488F-9727-CF9817353380"},
 {beforeRunningCommand: "nop",
  command: 
   "VW_MANPATH=$TM_VSCRIPT_MANUAL\n\npushd \"${VW_MANPATH}\" > /dev/null\nFILE=`grep -o \"<A name = \\\"${TM_CURRENT_WORD}\" *.html | cut -f 1 -d :`\npopd > /dev/null\nFILEPATH=\"${VW_MANPATH}/${FILE}\"\nLINES=`cat \"${FILEPATH}\" | tr '\\r' '\\n' | wc -l`\nSTARTLINE=`cat \"${FILEPATH}\" | tr '\\r' '\\n' | grep -n \"<\\!-- ${TM_CURRENT_WORD}\" | cut -f 1 -d :`\nTAILLINES=$((LINES-STARTLINE))\nHEADLINES=`cat \"${FILEPATH}\" | tr '\\r' '\\n' | tail -n $TAILLINES | grep -n \"^<\\!--\" | cut -f 1 -d : | head -n 1`\ncat \"${FILEPATH}\" | tr '\\r' '\\n' | tail -n $TAILLINES 2> /dev/null | head -n $((HEADLINES-1))",
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "^h",
  name: "Lookup",
  output: "showAsHTML",
  scope: "source.pascal.vectorscript",
  uuid: "A5E76858-928F-47F9-9A18-DE9E281364AC"}]
