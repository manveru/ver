# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#require_cmd gnatmake 'The GNAT Ada build system is available for free at<a href=\"http://www.macada.org/macada/Downloads.html\">macada.org</a>.'\n\n#cd \"$TM_DIRECTORY\"\n#gnatmake \"$TM_FILENAME\"\n#if [[ $? == 0 ]]; then\n#  SCRIPT=\"TM_DIRECTORY=$TM_DIRECTORY\"$'\\nTM_FILENAME='\"$TM_FILENAME\"$'\\ncd #\"$TM_DIRECTORY\" && clear && \"./${TM_FILENAME%.*}\" && exit'\n#  osascript <<APPLESCRIPT\n#    tell app \"Terminal\"\n#      activate\n#      do script \"${SCRIPT//\\\"/\\\"}\"\n#    end tell\n#APPLESCRIPT\n#fi\n\n. \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Compiling “${TM_FILENAME}”…\"\n\ncd \"$TM_DIRECTORY\"\ngnatmake \"$TM_FILENAME\" &> >(\"${TM_RUBY:-ruby}\" -rtm_parser -eTextMate.parse_errors)\nif (($? >= 1)); then exit; fi\n\n{ \"./${TM_FILENAME%.adb}\"\n  echo -e \"\\nProgram exited with status $?.\"; }|pre\n\n# # if you want to run the program in Terminal.app\n# osascript <<EOF\n#    tell application \"Terminal\"\n#       activate\n#       do script \"cd '$TM_DIRECTORY'; java '${TM_FILENAME%.java}'\"\n#    end tell\n# EOF\n\nhtml_footer\n",
  input: "selection",
  keyEquivalent: "@r",
  name: "Build and Run",
  output: "showAsHTML",
  scope: "source.ada",
  uuid: "97B21BF7-073D-4070-850C-DD8761B18DBC"}]
