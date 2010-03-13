# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\n\nfilepath = ENV['TM_FILEPATH']\n\nmachine = `sysctl hw.machine | awk -F\" \" '{print $2}'`.rstrip\nis64Bit = `sysctl hw.optional.x86_64 | awk -F\" \" '{print $2}'`.rstrip.to_i\n\ncmd_prefix = '6'\ncflags = ENV['TM_GO_CFLAGS']\n\ncase machine\nwhen 'arm'\n  cmd_prefix = '5'\nwhen 'i386'\n  if is64Bit == 0\n    cmd_prefix = '8'\n  end\nend\n\nTextMate.require_cmd \"\#{cmd_prefix}g\"\nTextMate.require_cmd \"gopack\"\n\nargs = [ENV['TM_BUNDLE_SUPPORT'] + '/go_run.rb', '--build-package']\nargs << \"--cflags=\\\"\#{cflags}\\\"\" unless cflags.nil?\nargs << filepath\n\nTextMate::Executor.run(args)",
  input: "none",
  keyEquivalent: "~@b",
  name: "Build Package",
  output: "showAsHTML",
  scope: "source.go",
  uuid: "F1FD1EA0-5743-4F54-ABB3-37C53452AF94"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/save_current_document\"\n\nTextMate.save_current_document('go')\nTextMate::Executor.make_project_master_current_document\n\nfilepath = ENV['TM_FILEPATH']\n\nmachine = `sysctl hw.machine | awk -F\" \" '{print $2}'`.rstrip\nis64Bit = `sysctl hw.optional.x86_64 | awk -F\" \" '{print $2}'`.rstrip.to_i\n\ncmd_prefix = '6'\ncflags = ENV['TM_GO_CFLAGS']\nlflags = ENV['TM_GO_LFLAGS']\n\nuse_gcc = (ENV['TM_GO_USE_GCC'] == '1')\nunless use_gcc\n  case machine\n  when 'arm'\n    cmd_prefix = '5'\n  when 'i386'\n    if is64Bit == 0\n      cmd_prefix = '8'\n    end\n  end\nend\n\nif use_gcc\n  TextMate.require_cmd 'gcc'\nelse\n  TextMate.require_cmd \"\#{cmd_prefix}g\"\n  TextMate.require_cmd \"\#{cmd_prefix}l\"\nend\n\nargs = [ENV['TM_BUNDLE_SUPPORT'] + '/go_run.rb']\nif use_gcc\n  args << '--use-gcc'\nelse\n  args << \"--compiler-prefix=\#{cmd_prefix}\"\nend\n\nargs << \"--cflags=\\\"\#{cflags}\\\"\" unless cflags.nil?\nargs << \"--lflags=\\\"\#{lflags}\\\"\" unless lflags.nil?\n\nargs << filepath\n\nTextMate::Executor.run(args)",
  input: "document",
  keyEquivalent: "@r",
  name: "Run",
  output: "showAsHTML",
  scope: "source.go",
  uuid: "0B3C3EB0-9F51-4997-A87D-ECA507D8E31E"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "if [[ \"$TM_SOFT_TABS\" = \"YES\" ]];\n\tthen export GOFMT_SPACES=\"-spaces\"\nfi\n\nrequire_cmd gofmt\n\nresult=`gofmt -oldparser=false ${GOFMT_SPACES} -tabwidth=${TM_TAB_SIZE} ${TM_FILEPATH} 2>&1`\nif [[ $? > 0 ]];\n\tthen exit_show_tool_tip \"Errors: $result\"\n\telse echo \"$result\"\nfi",
  input: "document",
  keyEquivalent: "^H",
  name: "Tidy",
  output: "replaceDocument",
  scope: "source.go",
  uuid: "B0271A46-F6EF-4D2F-95A6-EC067E69155C"}]
