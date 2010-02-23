# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "word=${TM_SELECTED_TEXT:-$TM_CURRENT_WORD}\n\ntry_man () {\n\tif man n -w \"$word\" &>/dev/null; then\n\t\tpage=$(\"$TM_SUPPORT_PATH/bin/html_man.sh\" n \"$word\")\n\t\techo \"<meta http-equiv='Refresh' content='0;URL=tm-file://$page'>\"\n\t\texit_show_html\n\tfi\n}\n\ntry_man\n\necho \"Couldn’t find documentation in 'man n' for “${word}”\"\n",
  dontFollowNewOutput: true,
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "^h",
  name: "Documentation for Word / Selection (man) copy",
  output: "showAsTooltip",
  scope: "source.tcl",
  uuid: "56F8C50E-B263-430C-9301-A34EDF05E9F5"},
 {beforeRunningCommand: "saveActiveFile",
  command: "${TM_TCLSH:=tclsh} \"$TM_FILEPATH\"|pre",
  input: "none",
  keyEquivalent: "@r",
  name: "Run",
  output: "showAsHTML",
  scope: "source.tcl",
  uuid: "59700A78-7CB7-11D9-875B-000A95E13C98"}]
