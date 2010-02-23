# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Documentation for Word\" \"Common Lisp HyperSpec\"\nread KEYWORD\necho \"<ul>\"\ncurl -s \"http://www.lisp.org/HyperSpec/FrontMatter/Symbol-Index-Alphabetical.html\" | grep -E \"<LI><A.* HREF=\\\".+\\\"><B>.*$KEYWORD.*</B></A>\" | sed -E \"s/<LI><A.* HREF=\\\"\\.\\.(.+)\\\"><B>(.+)<\\/B><\\/A>/<li><a href=\\\"http:\\/\\/www.lisp.org\\/HyperSpec\\1\\\">\\2<\\/a><\\/li>/\"\necho \"</ul>\"\nhtml_footer\n",
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "^h",
  name: "Documentation for Word",
  output: "showAsHTML",
  scope: "source.lisp",
  uuid: "DCCF29B4-80E9-4DF8-A9EC-28F91611665F"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Lisp Bundle Help\" \"Lisp\"\n\"$TM_SUPPORT_PATH/lib/markdown_to_help.rb\" \"$TM_BUNDLE_SUPPORT/help.markdown\"\nhtml_footer\n",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  scope: "source.lisp",
  uuid: "0D68EA05-DF84-4EE3-89A1-1A57FB2BAE59"}]
