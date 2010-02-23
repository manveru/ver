# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/ruby\n\ncomments = <<-\"end-comment\"\n##\n# $0\n# \n# @author $USER\nend-comment\nprint comments.chomp",
  fallbackInput: "none",
  input: "none",
  name: "Start Comments",
  output: "insertAsSnippet",
  scope: "source.ruby",
  tabTrigger: "##",
  uuid: "11314DEC-DEC2-4F8C-BC58-C5484D9651B9"}]
