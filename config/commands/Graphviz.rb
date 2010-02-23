# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "require_cmd dot\n\n. \"${TM_SUPPORT_PATH}/lib/html.sh\"\n. \"${TM_SUPPORT_PATH}/lib/webpreview.sh\"\n\n# Prepare output window.\nhtml_header 'Generate Graph' \"$FILE\"\nSRC=${TM_FILENAME:-untitled.dot}\nDST=\"${TMPDIR:-/tmp}/dot_${SRC%.*}.pdf\"\nERR=\"${TMPDIR:-/tmp}/dot_errors\"\n\n# Compile.\nif dot -Tpdf -o \"$DST\" /dev/stdin &>\"$ERR\"; then\n  echo \"<meta http-equiv='refresh' content='0; tm-file://$DST'>\"\nelse\n  pre <\"$ERR\"\nfi\nrm -f \"$ERR\"\nhtml_footer\n",
  input: "document",
  keyEquivalent: "@r",
  name: "Generate Graph",
  output: "showAsHTML",
  scope: "source.dot",
  uuid: "726F7253-079F-49E1-A9DF-739BBFFB321D"}]
