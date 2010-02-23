# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\n\nCOMMAND=`cat | tr -d ' \\t' | grep -m1 -o '^\\w\\+' | tr 'a-z' 'A-Z'`\n\nhtml_header \"Documentation for $COMMAND\"\n\"${TM_CMAKE:-cmake}\" --help-command \"$COMMAND\" | pre\nhtml_footer\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "^h",
  name: "Documentation For Command",
  output: "showAsHTML",
  scope: "source.cmake meta.function-call, source.cmake",
  uuid: "6AA1ED0A-6E0F-48EC-965C-D57AD98A100B"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/textmate'\n\nabort \"Unsaved file\" unless ENV['TM_FILEPATH']\n\npath = File.dirname(File.dirname(ENV['TM_FILEPATH'])) + \"/CMakeLists.txt\"\nabort \"No parent listfile\" unless File.exist?(path)\nTextMate.go_to(:file => path)\n\n# subdir = nil\n# \n# if line =~ /ADD_SUBDIRECTORY\\s*\\((.+?)\\)/i\n#   subdir = $1\n# else\n#   subdirs = Dir[dir + \"/*/CMakeLists.txt\"].map { |p| File.basename(File.dirname(p)) }.sort\n#   abort \"No listfile found in subdirectories\" if subdirs.empty?\n#   choice = TextMate::UI.menu(subdirs)\n#   abort \"Cancelled\" unless choice\n#   subdir = subdirs[choice]\n# end\n# \n# if subdir\n#   file = subdir + \"/CMakeLists.txt\"\n#   path = File.join(dir, file)\n#   abort \"The file at \#{file} doesn't exist\" unless File.exist?(path)\n#   TextMate.go_to(:file => path)\n# end\n",
  fallbackInput: "line",
  input: "none",
  keyEquivalent: "~@",
  name: "Move to Parent Listfile",
  output: "showAsTooltip",
  scope: "source.cmake",
  uuid: "48A1D967-E8CF-4C16-A58F-60471E9469E3"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/textmate'\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/ui'\n\nabort \"Unsaved file\" unless ENV['TM_FILEPATH']\n\nline   = STDIN.read\ndir    = File.dirname(ENV['TM_FILEPATH'])\nsubdir = nil\n\nif line =~ /ADD_SUBDIRECTORY\\s*\\((.+?)\\)/i\n  subdir = $1\nelse\n  subdirs = Dir[dir + \"/*/CMakeLists.txt\"].map { |p| File.basename(File.dirname(p)) }.sort\n  abort \"No listfile found in subdirectories\" if subdirs.empty?\n  choice = TextMate::UI.menu(subdirs)\n  abort \"Cancelled\" unless choice\n  subdir = subdirs[choice]\nend\n\nif subdir\n  file = subdir + \"/CMakeLists.txt\"\n  path = File.join(dir, file)\n  abort \"The file at \#{file} doesn't exist\" unless File.exist?(path)\n  TextMate.go_to(:file => path)\nend\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "~@",
  name: "Move to Subdirectory Listfile",
  output: "showAsTooltip",
  scope: "source.cmake",
  uuid: "6F326FB4-8DC0-49BE-B74C-7B49CFA5283F"}]
