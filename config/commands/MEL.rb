# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Maya Embedded Language Help\" \"MEL\"\nMarkdown.pl <<'EOF'\n## Send to Maya\n\nRunning this command will execute either the current selection or the entire script in Maya, using commandPort. Before doing this, Maya must run the following command:\n\n\tcommandPort -n \":2222\";\n\t\nIt is recommended to save that command to a shelf.\n\nEOF\nhtml_footer\n",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  scope: "source.mel",
  uuid: "1687B611-98C8-4324-A1B1-88978692C4DB"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n#  Created by Jon Roberts on 2007-10-18.\n# Maya must first run the command:\n# commandPort -n \":2222\";\n\nrequire 'socket'\n\nbegin\n  mel = STDIN.read\n  s = TCPSocket.open(\"localhost\", 2222)\n  s.puts(mel)\nrescue Exception => e\n  puts(\"Error:\\n\"+e+\"\\n...is commandPort enabled? See help command.\")\nend\n",
  fallbackInput: "document",
  input: "selection",
  keyEquivalent: "@r",
  name: "Send to Maya",
  output: "showAsTooltip",
  scope: "source.mel",
  uuid: "F122D96A-781F-4934-89AD-3BE0BFCDB3C1"}]
