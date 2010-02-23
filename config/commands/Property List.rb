# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "if [[ -f \"$TM_FILEPATH\" ]]\n\tthen\n\t\tfirst_line=$(head -n1 \"$TM_FILEPATH\")\n\t\tif [[ ${first_line:0:6} == \"bplist\" ]]\n\t\t\tthen\n\t\t\t\tplutil -convert xml1 -o /tmp/textmate_converted_plist.xml \"$TM_FILEPATH\"\n\t\t\t\tcat /tmp/textmate_converted_plist.xml\n\t\t\telse exit_show_tool_tip \"File does not appear to be a binary property list.\"\n\t\tfi\n\telse exit_show_tool_tip \"File must be saved before conversion.\"\nfi\n",
  input: "document",
  keyEquivalent: "^H",
  name: "Convert Binary to XML",
  output: "replaceDocument",
  scope: "source.plist.binary",
  uuid: "000A245B-4BDD-4544-8200-C5BE3EFEDC20"},
 {beforeRunningCommand: "nop",
  command: 
   "if [[ -f \"$TM_FILEPATH\" ]] && [ $(grep -ao \"^......\" \"$TM_FILEPATH\"|head -n1) == \"bplist\" ]\n   then plutil -convert xml1 -o >(cat) \"$TM_FILEPATH\"|pl\n   else pl\nfi",
  input: "document",
  keyEquivalent: "^H",
  name: "Convert to Old-Style ASCII",
  output: "openAsNewDocument",
  scope: "text.xml.plist, source.plist.binary",
  uuid: "827E8A23-2C7A-4BDD-987F-A3B67B51F239"},
 {beforeRunningCommand: "nop",
  command: 
   "# Xcode 2.1 supports preprocessed plist files\n# CPP's authors couldn't be bothered to support stdin\nTEMP_FILE1=`mktemp /tmp/TextMate_plist.XXXXXX`\nTEMP_FILE2=`mktemp /tmp/TextMate_plist_pre.XXXXXX`\nif [[ -n $TEMP_FILE1 ]]; then\n\tcat > \"$TEMP_FILE1\"\n\tcpp -P \"$TEMP_FILE1\" \"$TEMP_FILE2\"\n\tplutil -lint \"$TEMP_FILE2\"\n\trm \"$TEMP_FILE1\"\n\trm \"$TEMP_FILE2\"\nelse\n\techo \"Error: Temporary file could not be created\"\nfi",
  input: "document",
  keyEquivalent: "^V",
  name: "Preprocess and Validate Syntax",
  output: "showAsTooltip",
  scope: "source.plist -source.plist.binary",
  uuid: "A7240D98-3452-42FC-A3D8-960F1E992AD2"},
 {beforeRunningCommand: "nop",
  command: 
   "TEMP_FILE=`mktemp /tmp/TextMate_plist.XXXXXX`\nif [[ -n $TEMP_FILE ]]; then\n\tcat > \"$TEMP_FILE\"\n\tplutil -lint \"$TEMP_FILE\"|perl -pe \"s|\\\\Q$TEMP_FILE\\\\E:\\s*||\"\n\trm \"$TEMP_FILE\"\nelse\n\techo \"Error: Temporary file could not be created\"\nfi",
  input: "document",
  keyEquivalent: "^V",
  name: "Validate Syntax",
  output: "showAsTooltip",
  scope: "source.plist, text.xml.plist",
  uuid: "DA0A5096-5F16-11D9-B9C3-000D93589AF6"}]
