# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nTM_LUAC = ENV['TM_LUAC'] || (ENV['TM_LUA'] ? \"\#{ENV['TM_LUA']}c\" : \"luac\")\n\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/textmate'\n\nTextMate.require_cmd \"\#{TM_LUAC}\"\n\nputs \"using \#{TM_LUAC}\"\nresult = `\"\#{TM_LUAC}\" -p - 2>&1`\nputs result\n\nregexp = /^luac: stdin:(\\d+):/\n\nif result =~ regexp\n  TextMate.go_to :line => $1\nelse\n  puts \"Syntax OK\"\nend\n",
  input: "document",
  keyEquivalent: "^V",
  name: "Check Syntax",
  output: "showAsTooltip",
  scope: "source.lua",
  uuid: "E2D1F434-A472-4185-9933-4D9408C6C4D0"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   ": ${TM_LUA:=lua}\nrequire_cmd \"$TM_LUA\"\n\"$TM_LUA\" \"$TM_FILEPATH\"|pre",
  input: "none",
  keyEquivalent: "@r",
  name: "Run Script",
  output: "showAsHTML",
  scope: "source.lua",
  uuid: "BF303CAC-FF2B-4299-8F2B-C84FE64B5146"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/bin/bash\n[[ -z \"$TM_FILEPATH\" ]] && TM_TMPFILE=$(mktemp -t pythonInTerm)\n: \"${TM_FILEPATH:=$TM_TMPFILE}\"; cat >\"$TM_FILEPATH\"\n\n: ${TM_LUA:=lua}\nrequire_cmd \"$TM_LUA\"\n\nesc () {\nSTR=\"$1\" ruby <<\"RUBY\"\n   str = ENV['STR']\n   str = str.gsub(/'/, \"'\\\\\\\\''\")\n   str = str.gsub(/[\\\\\"]/, '\\\\\\\\\\\\0')\n   print \"'\#{str}'\"\nRUBY\n}\n\nosascript <<- APPLESCRIPT\n\ttell app \"Terminal\"\n\t    launch\n\t    activate\n\t    do script \"clear; cd $(esc \"${TM_DIRECTORY}\"); $(esc \"${TM_LUA}\") $(esc \"${TM_FILEPATH}\"); rm -f $(esc \"${TM_TMPFILE}\")\"\n\t    set position of first window to { 100, 100 }\n\tend tell\nAPPLESCRIPT\n\n",
  input: "document",
  keyEquivalent: "@R",
  name: "Run Script (Terminal)",
  output: "discard",
  scope: "source.lua",
  uuid: "C7B74C19-5DB5-47A1-A148-3A1019EF4D96"}]
