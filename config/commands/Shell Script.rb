# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/bin/bash\nword=${TM_SELECTED_TEXT:-$TM_CURRENT_WORD}\n\ntry_help () {\n\tif help \"$word\" &>/dev/null; then\n\t\tsource \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\n\t\thtml_header \"Documentation for \\\"$word\\\"\"\n\t\thelp \"$word\" | pre\n\t\thtml_footer\n\t\texit_show_html\n\telif man -w \"$word\" &>/dev/null; then\n\t\tpage=$(\"$TM_SUPPORT_PATH/bin/html_man.sh\" -a \"$word\")\n\t\techo \"<meta http-equiv='Refresh' content='0;URL=tm-file://$page'>\"\n\t\texit_show_html\n\tfi\n}\n\nMANSECT=${MANSECT:-2:3:4:5:6:7:8:9} try_help\ntry_help\n\necho \"Couldn’t find documentation for “${word}”\"\n",
  dontFollowNewOutput: true,
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "^h",
  name: "Documentation for Word / Selection",
  output: "showAsTooltip",
  uuid: "776163E4-730B-11D9-BCD0-000D93589AF6"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#!/bin/bash\nif chmod +x \"${TM_FILEPATH}\" && [[ -x \"${TM_FILEPATH}\" ]]\n   then echo \"${TM_FILEPATH} is now executable\"\n   else echo \"Failed making ${TM_FILEPATH} executable\"\nfi",
  input: "none",
  keyEquivalent: "^@X",
  name: "Make Script Executable",
  output: "showAsTooltip",
  uuid: "200ED3B8-A64B-11D9-B384-000D93382786"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/bin/bash\nNAME=\"$(cat)\"\nif [[ -z \"$NAME\" ]]; then\n\tNAME='${1:function_name}'\nfi\n\ncat <<SNIPPET\nfunction $NAME () {\n\t\\${0:#statements}\n}\nSNIPPET",
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "$\n",
  name: "New Function",
  output: "insertAsSnippet",
  scope: "source.shell",
  tabTrigger: "fun",
  uuid: "74ED8466-F6E5-48F8-8063-E252C2A36353"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -wKU\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/escape.rb'\n\ndef find_directory\n  files = [ ENV['TM_SELECTED_FILE'], ENV['TM_FILEPATH'], ENV['TM_DIRECTORY'], ENV['TM_PROJECT_DIRECTORY'], ENV['HOME'] ]\n  res = files.find { |file| file && File.exists?(file) }\n  res && File.file?(res) ? File.split(res).first : res\nend\n\ndef is_running(process)\n  all = `ps -U \"$USER\" -o ucomm`\n  all.to_a[1..-1].find { |cmd| process == cmd.strip }\nend\n\ndef terminal_script(dir)\n  return <<-APPLESCRIPT\n    tell application \"Terminal\"\n      activate\n      do script \"cd \#{e_as(e_sh(dir))}; clear; pwd\"\n    end tell\nAPPLESCRIPT\nend\n\ndef iterm_script(dir)\n  return <<-APPLESCRIPT\n    tell application \"iTerm\"\n      activate\n      if exists the first terminal then\n        set myterm to the first terminal\n      else\n        set myterm to (make new terminal)\n      end if\n      tell myterm\n        activate current session\n        launch session \"Default Session\"\n        tell the last session\n          write text \"cd \#{e_as(e_sh(dir))}; clear; pwd\"\n        end tell\n      end tell\n    end tell\nAPPLESCRIPT\nend\n\nif dir = find_directory\n  script = nil\n  if ENV['TM_TERMINAL'] =~ /^iterm$/i || is_running('iTerm')\n    script = iterm_script(dir)\n  else\n    script = terminal_script(dir)\n  end\n  open(\"|osascript\", \"w\") { |io| io << script }\nend\n",
  input: "none",
  keyEquivalent: "^O",
  name: "Open Terminal",
  output: "discard",
  uuid: "54CDB56E-85EA-11D9-B369-000A95E13C98"},
 {autoScrollOutput: 1,
  beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/save_current_document\"\n\nTextMate.save_current_document\nTextMate::Executor.make_project_master_current_document\n\nTextMate::Executor.run(ENV[\"TM_SHELL\"] || ENV[\"SHELL\"] || \"bash\", ENV[\"TM_FILEPATH\"])",
  input: "document",
  keyEquivalent: "@r",
  name: "Run Script",
  output: "showAsHTML",
  scope: "source.shell",
  uuid: "7207ACC2-A64B-11D9-B384-000D93382786"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nprint case str = STDIN.read\n  when /\\A`(.*)`\\z/m     then '$(' + $1 + ')'\n  when /\\A\\$\\((.*)\\)\\z/m then '`' + $1 + '`'\n  else str\nend\n",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "^\"",
  name: "Toggle Backticks",
  output: "replaceSelectedText",
  scope: "source.shell string.interpolated",
  uuid: "3602A889-81F7-422B-BC0E-3FB0543CEA9C"}]
