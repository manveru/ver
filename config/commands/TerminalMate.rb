# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\n$LOAD_PATH << \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib\"\nrequire \"terminal_mate\"\n\nfile_ext = ENV[\"TERMINAL_MATE_FILE_EXTENSION\"].to_s\ntm_filepath = ENV[\"TM_FILEPATH\"]\nif tm_filepath.nil?\n  tmpfile = `mktemp -t TerminalMate`.chomp # Couldn't get Tempfile to work…\n  tmpfile += file_ext\n  File.open(tmpfile, \"w\") do |f| f.write(STDIN.read) end\n  file = tmpfile\n  File.chmod(0755, file) if file_ext == \".sh\"\nelse\n  file = tm_filepath\nend\nTerminalMate::Client.new.send(\"load_file\", ENV[\"TM_SCOPE\"], ENV[\"TERMINAL_MATE_LOAD\"] % file)\n",
  input: "document",
  keyEquivalent: "^I",
  name: "Load File",
  output: "afterSelectedText",
  scope: "source",
  uuid: "964A0E53-3896-4EC6-AC15-038DC8FCEEE2"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n$LOAD_PATH << \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib\"\nrequire \"terminal_mate\"\nTerminalMate::Client.new.send(\"new\", ENV[\"TM_SCOPE\"], ENV[\"TM_PROJECT_DIRECTORY\"], ENV[\"TERMINAL_MATE_NEW\"])\n",
  input: "none",
  keyEquivalent: "^I",
  name: "New Terminal",
  output: "afterSelectedText",
  scope: "source",
  uuid: "8F305E73-F68F-4A5D-B04B-A8646F2CC695"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n$LOAD_PATH << \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib\"\nrequire \"terminal_mate\"\nTerminalMate::Client.new.send(\"paste\", ENV[\"TM_SCOPE\"], STDIN.read)\n",
  fallbackInput: "document",
  input: "selection",
  keyEquivalent: "^I",
  name: "Paste Selection",
  output: "discard",
  scope: "source",
  uuid: "3B47B103-857B-4A75-938B-4D57D4803BC2"}]
