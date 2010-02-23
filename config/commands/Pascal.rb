# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "require_cmd fpc 'The Free Pascal Compiler is available from <a href=\"http://www.freepascal.org/\">http://www.freepascal.org/</a>'\n\ncd \"$TM_DIRECTORY\"\nfpc \"$TM_FILENAME\"\nif [[ $? == 0 ]]; then\n  SCRIPT=\"TM_DIRECTORY=$TM_DIRECTORY\"$'\\nTM_FILENAME='\"$TM_FILENAME\"$'\\ncd \"$TM_DIRECTORY\" && clear && \"./${TM_FILENAME%.*}\" && exit'\n  osascript <<APPLESCRIPT\n    tell app \"Terminal\"\n      activate\n      do script \"${SCRIPT//\\\"/\\\"}\"\n    end tell\nAPPLESCRIPT\nfi\n",
  input: "none",
  keyEquivalent: "@r",
  name: "Run",
  output: "showAsHTML",
  scope: "source.pascal",
  uuid: "8E597879-2721-424B-B4F5-974259B67697"}]
