# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "# put a regular expression on the clipboard and select text to be searched. Output is your document with all matches highlighted.\n# add a -x before the -c to omit nonmatching lines.\n# Replace `pbpaste` with a regexp string if you don't like copying first.\n# You can replace or reorder the color list with any html-okay colors or #ffffff values.\n\necho \"<html><head></head><body>\"\necho \"<h3>Results for /`pbpaste`/</h3><tt>\"\n\n\"$TM_BUNDLE_SUPPORT/bin/hl.pl\" -c \"Red\",\"Dark Blue\",\"Dark Purple\",\"Brown\",\"Burgundy\",\"Forest Green\",\"Yellow\",\"Pastel Green\",\"Light Purple\",\"Pink\",\"Turquoise\",\"Light Blue\",\"Dark Grey\",\"Orange\",\"Grass Green\" \"`pbpaste`\"\n\necho \"</tt></body></html>\"",
  input: "selection",
  keyEquivalent: "^~@x",
  name: "Test RegExp in Clipboard",
  output: "showAsHTML",
  uuid: "8FDBC987-A543-11D9-B374-000D9332809C"},
 {beforeRunningCommand: "nop",
  command: 
   "# Select a regular expression in your text; this command will show you matches in the rest of your text.\n# First line of input is expected to be a regular\n# expression. If we're doing matching, leave out the /slashes/, eg:\n# (.+)z\n# If we're doing substitution, use slashes to identify the expression as such:\n# /old/new/ \n# Every line after the first is match fodder, used to test the regexp.\n\nruby \"$TM_BUNDLE_SUPPORT/bin/rx_helper.rb\"|pre",
  input: "selection",
  keyEquivalent: "^~@x",
  name: "Test RegExp in First Line",
  output: "showAsHTML",
  uuid: "7EB957A4-A531-11D9-917B-000D9332809C"}]
