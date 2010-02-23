# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "TM_RUBY=\"${TM_RUBY:=ruby}\"\nSUPPORT_PATH=${TM_BUNDLE_SUPPORT:=\"$TM_BUNDLE_PATH/Support\"}\nBROWSER=\"${SUPPORT_PATH}/browser.rb\"\n\n$TM_RUBY \"$BROWSER\" \"${TM_PROJECT_DIRECTORY:-TM_DIRECTORY}\" \"$SUPPORT_PATH\"",
  input: "none",
  keyEquivalent: "^I",
  name: "Browse",
  output: "showAsHTML",
  uuid: "B0869DF4-B5E2-48A5-8550-5BABE67F6D25"}]
