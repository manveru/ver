# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "cd \"$TM_DIRECTORY\"\nFILE=`basename \"$TM_FILENAME\" .lgt`\n$LOGTALK_COMMAND \"logtalk_compile($FILE), halt.\"\n",
  input: "none",
  name: "Compile",
  output: "openAsNewDocument",
  scope: "source.logtalk",
  uuid: "2AC5EDAA-D94D-43E5-A685-D0F89AC665DD"},
 {beforeRunningCommand: "nop",
  command: 
   "cd \"$TM_DIRECTORY\"\nFILE=`basename \"$TM_FILENAME\" .lgt`\n$LOGTALK_COMMAND \"logtalk_compile($FILE), halt.\"\n$LOGTALK_PDF_COMMAND\nopen *.pdf\n",
  input: "none",
  name: "Generate PDF documentation",
  output: "openAsNewDocument",
  scope: "source.logtalk",
  uuid: "885F35BF-59A5-4746-A554-E4B558690871"},
 {beforeRunningCommand: "nop",
  command: 
   "cd \"$TM_DIRECTORY\"\nFILE=`basename \"$TM_FILENAME\" .lgt`\n$LOGTALK_COMMAND \"logtalk_compile($FILE), halt.\"\nlgt2txt\nopen *.txt\n",
  input: "none",
  name: "Generate TEXT documentation",
  output: "openAsNewDocument",
  scope: "source.logtalk",
  uuid: "69FAC018-D43E-4AF7-AAB2-65F200E53709"},
 {beforeRunningCommand: "nop",
  command: 
   "cd \"$TM_DIRECTORY\"\nFILE=`basename \"$TM_FILENAME\" .lgt`\n$LOGTALK_COMMAND \"logtalk_compile($FILE), halt.\"\nlgt2html\nopen index.html\n",
  input: "none",
  name: "Generate XHTML documentation",
  output: "openAsNewDocument",
  scope: "source.logtalk",
  uuid: "F1BFEF71-F4BF-4CB2-A94A-E2AEC5BBD876"}]
