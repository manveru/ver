# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "# Start a new shell if needed, otherwise show the one with the right name.\nexport SHELL_NAME=${SHELL_NAME:=\"TextMate Shell\"}\n\"$TM_BUNDLE_SUPPORT/new.sh\"\n",
  input: "none",
  keyEquivalent: "^I",
  name: "Interactive Shell",
  output: "discard",
  uuid: "E7E68111-54E4-4C01-8DBA-9D9FFD38FF2C"},
 {beforeRunningCommand: "nop",
  command: 
   "export SHELL_NAME=${SHELL_NAME:=\"TextMate Shell\"}\n\"$TM_BUNDLE_SUPPORT/new.sh\"\nPASTE=$(echo \"$TM_FILEPATH\" | sed s/\\\"/\\\\\\\\\\\"/g)\nosascript << END\ntell application \"iTerm\"\n\ttell first terminal\n\t\ttell session named \"$SHELL_NAME\"\n\t\t\twrite text \"$PASTE\"\n\t\tend tell\n\tend tell\nend tell\nEND\n",
  input: "none",
  keyEquivalent: "^I",
  name: "Paste Filepath",
  output: "discard",
  uuid: "BED3AE43-7F29-4F92-B2F1-3361B4ACC71A"},
 {beforeRunningCommand: "nop",
  command: 
   "export SHELL_NAME=${SHELL_NAME:=\"TextMate Shell\"}\n\"$TM_BUNDLE_SUPPORT/new.sh\"\nPASTE=$(echo \"$TM_SELECTED_TEXT\" | sed s/\\\"/\\\\\\\\\\\"/g)\nosascript << END\ntell application \"iTerm\"\n\ttell first terminal\n\t\ttell session named \"$SHELL_NAME\"\n\t\t\twrite text \"$PASTE\"\n\t\tend tell\n\tend tell\nend tell\nEND\n",
  input: "none",
  keyEquivalent: "^I",
  name: "Paste Selection",
  output: "discard",
  uuid: "02E5581D-BCC8-4479-A9A9-A5E7CEE8293E"}]
