# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  bundleUUID: "D99E8C0C-792F-11D9-A212-000D93B3A10E",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Balance Jr Help\"\nMarkdown.pl \"$TM_BUNDLE_SUPPORT/Balance Jr Help.markdown\"\nhtml_footer\n",
  input: "none",
  name: "Balance Jr Help",
  output: "showAsHTML",
  uuid: "0F1EF848-5333-4610-96FE-97C180B2653C"},
 {beforeRunningCommand: "nop",
  command: 
   "cat <<'PART_1'\n\t<html><head><title>Clock</title><script>\n\tvar myCommand = null;\n\n\tfunction start () {\n\t   document.getElementById(\"start\").style.display = \"none\";\n\t   document.getElementById(\"stop\").style.display = \"inline\";\n\t   var cmd = \"while true; do date; sleep 1; done\"\n\t   myCommand = TextMate.system(cmd, function (task) { });\n\t   myCommand.onreadoutput = output;\n\t}\n\n\tfunction stop () {\n\t   document.getElementById(\"start\").style.display = \"inline\";\n\t   document.getElementById(\"stop\").style.display = \"none\";\n\t   myCommand.cancel();\n\t}\n\n\tfunction output (str) {\n\t   document.getElementById(\"date\").innerText = str;\n\t}\n\t</script></head>\n\t<body onLoad=\"window.resizeTo(400, 250); start()\" onUnload=\"stop()\">\n\t<pre><div id=\"date\">\nPART_1\n\ndate|tr -d \\\\n # to get an initial value (visually more attractive)\n\ncat <<'PART_2'\n\t</div></pre>\n\t<span id=\"start\"><a onClick=\"start()\" href=\"#\">Start</a></span>\n\t<span id=\"stop\"><a onClick=\"stop()\" href=\"#\">Stop</a></span>\n\t</body></html>\nPART_2\n",
  input: "none",
  keyEquivalent: "",
  name: "Clock",
  output: "showAsHTML",
  uuid: "8FC2E9FA-A9CE-42CD-9910-4FC9A9248BF9"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire 'rexml/streamlistener'\nrequire 'rexml/parsers/baseparser'\nrequire 'rexml/parsers/streamparser'\n\n\n$noparens = ['source.ocaml']\n$nocommas = ['source.ocaml']\n\n\nclass FunctionExtractor\n\tinclude REXML::StreamListener\n\t\n\tdef initialize(findfunction)\n\t\t@findfunction = findfunction\n\t\t@functiontagregex = /^declaration\\.function|^meta\\.(method|function)/\n\t\t@functionnameregex = /^entity\\.name\\.function/\n\t\t@argumentregex = /^variable/\n\t\t@infunction = false\n\t\t@currenttag = \"\"\n\t\t@currentfunction = \"\"\n\t\t@args = []\n\tend\n\t\n\t\n\tdef tag_start(name, attrs)\n\t\tif !@infunction and @functiontagregex.match(name)\n\t\t\t@infunction = name\n\t\telsif @infunction\n\t\t\t@currenttag = name\n\t\tend\n\tend\n\t\n\t\n\tdef text(txt)\n\t\tif @infunction\n\t\t\tif @functionnameregex.match(@currenttag)\n\t\t\t\t@currentfunction = txt.strip()\n\t\t\telsif @argumentregex.match(@currenttag)\n\t\t\t\t@args << txt.strip()\n\t\t\tend\n\t\tend\n\tend\n\t\n\t\n\tdef tag_end(name)\n\t\tif @infunction\n\t\t\tif name == @infunction\n\t\t\t\tif @currentfunction == @findfunction\n\t\t\t\t\tprint \"\#{make_args()}$0\"\n\t\t\t\t\texit(0)\n\t\t\t\tend\n\t\t\t\t\n\t\t\t\t@args = []\n\t\t\t\t@infunction = false\n\t\t\telsif name == @currenttag\n\t\t\t\t@currenttag = \"\"\n\t\t\tend\n\t\tend\n\tend\n\n\t\n\tprivate\n\t\n\tdef make_args()\n\t\tscope = ENV['TM_SCOPE'].split(/ /)[0]\n\t\tjoinstr = \", \"\n\t\tif $nocommas.include?(scope)\n\t\t\tjoinstr = \" \"\n\t\tend\n\n\t\tif !$nocommas.include?(scope)\n\t\t\t@args = @args.map { |s| s.split(/,/) }.flatten.map { |s| s.strip() }\n\t\telse\n\t\t\t@args = @args.map { |s| s.split(/\\s+/) }.flatten.map { |s| s.strip() }\n\t\tend\n\t\t\n\t\tfinal = []\n\t\t@args.each_index() do |i|\n\t\t\tfinal << \"${\#{i+1}:\#{@args[i]}}\"\n\t\tend\n\n\t\tfinal = final.join(joinstr)\n\t\tif $noparens.include?(scope)\n\t\t\tfinal = \" \#{final}\"\t\t\t\n\t\telse\n\t\t\tfinal = \"(\#{final})\"\n\t\tend\n\t\t\n\t\tfinal\n\tend\n\t\nend\n\nbegin\n\tlistener = FunctionExtractor.new(ENV['TM_CURRENT_WORD'].strip())\n\tparser = REXML::Parsers::StreamParser.new($stdin, listener)\n\tparser.parse()\nrescue\n\t# if we fail for any reason, we want to fail silently to avoid cluttering up the document\nend",
  input: "document",
  inputFormat: "xml",
  keyEquivalent: "~",
  name: "Complete Local Function",
  output: "insertAsSnippet",
  scope: "source",
  uuid: "08741F60-A1F1-4294-B9A9-FFF43253A687"},
 {beforeRunningCommand: "nop",
  command: "\"$TM_BUNDLE_SUPPORT/bin/convert_to_snippet.rb\"",
  fallbackInput: "none",
  input: "selection",
  name: "Convert to Snippet",
  output: "insertAsSnippet",
  uuid: "99D9DBC0-E03E-46B9-9E73-13F58DCDB55B"},
 {beforeRunningCommand: "nop",
  bundleUUID: "AEAF4DD4-74CD-11D9-BAD4-000A95A89C98",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Basic Subversion Diff\"\n\"${TM_RUBY:-ruby}\" \"$TM_BUNDLE_SUPPORT/svn_diff_html.rb\"\nhtml_footer\n",
  input: "none",
  name: "Diff With Working Copy as HTML (BASE)",
  output: "showAsHTML",
  uuid: "44AE6B57-2AD5-4D06-972B-EEFA6FC3F266"},
 {beforeRunningCommand: "nop",
  bundleUUID: "467B298F-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion\"\n\ndef letsdoit(stdin)\n  choices = TextmateCompletionsText.new(`cat /usr/share/dict/web2|grep ^\#{Regexp.escape ENV['TM_CURRENT_WORD']}|head -n 500`).to_ary\n  print TextmateCodeCompletion.new(choices,stdin).to_snippet\nend\n\nletsdoit(STDIN.read)\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "~",
  name: "English Completion",
  output: "insertAsSnippet",
  scope: "text -source, string -(string source)",
  uuid: "9AA55A9A-ED50-4494-B814-50FD21CDF535"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\n# short for escape_snippet - escapes special snippet characters in str\ndef es(str)\n\tstr.to_s.gsub(/([$`\\\\])/, \"\\\\\\\\\\\\1\")\nend\n\n\n# given a string, insert an open parenthesis in the first, best\n# spot starting from the end\ndef insert_open(str)\t\n\t# this needs to be done as a state machine so we can properly jump\n\t# paren groups\n\tprev = nil\n\tcur = nil\n\tclosuredepth = 0\n\t(str.length - 1).downto(0) do |i|\n\t\tprev = cur\n\t\tcur = str[i].chr()\n\t\t\n\t\tif prev != nil\n\t\t\tif prev == '('\n\t\t\t\tclosuredepth -= 1\n\t\t\telsif prev == ')'\n\t\t\t\tclosuredepth += 1\n\t\t\tend\n\t\t\t\n\t\t\t# look for the start of a token next to a boundary\n\t\t\tif closuredepth == 0 and \"\#{cur}\#{prev}\" =~ /(\\b|\\s)[a-zA-Z0-9\\(]$/\n\t\t\t\treturn str[0..i] + '(' + str[i+1..-1]\n\t\t\tend\n\t\tend\n\tend\n\t\n\t# if we bailed, check for start of str positioning\n\tif str =~ /^[a-zA-Z0-9\\(]/\n\t\treturn '(' + str\n\telse\n\t\treturn str\t\n\tend\nend\n\n\nline = $stdin.read()\nindex = ENV['TM_LINE_INDEX'].to_i()\ncurrentchar = line[index - 1].chr()\n\nif currentchar == ')'\n\t# backtrack to find the open of this paren\n\tdepth = 1\n\tsearchline = line[0..(index - 2)].reverse\n\tsearchline.split(//).each_index() do |i|\n\t\tch = searchline[i].chr()\n\t\tif ch == ')'\n\t\t\tdepth += 1\n\t\telsif ch == '('\n\t\t\tdepth -= 1\n\t\tend\n\n\t\t# at a depth of zero we should be sitting on the opening paren\n\t\tif depth == 0\n\t\t\tparenindex = [(index - 3 - i), 0].max()\n\t\t\tfirstpart = line[0].chr()\n\t\t\tif parenindex > 0\n\t\t\t\tfirstpart = insert_open(line[0..parenindex])\n\t\t\tend\n\t\t\tif firstpart == line[0..parenindex]\n\t\t\t\tline = es(line[0..(index)]) + '$0' + es(line[(index + 1)..-1])\n\t\t\t\tbreak\n\t\t\tend\n\t\t\t\n\t\t\tsecondpart = es(line[(parenindex + 2)..(index - 2)]) + ')$0' + es(line[index..-1])\n\t\t\tline = es(firstpart) + secondpart\n\t\t\tbreak\n\t\tend\n\tend\nelse\n\tline = es(insert_open(line[0..(index - 1)])) + ')$0' + es(line[index..-1])\nend\n\nprint \"\#{line}\"\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "@)",
  name: "Extend Current Parens",
  output: "insertAsSnippet",
  scope: "source",
  uuid: "775D0733-3804-463C-A0EF-65B2998F5CE1"},
 {beforeRunningCommand: "nop",
  bundleUUID: "AEAF4DD4-74CD-11D9-BAD4-000A95A89C98",
  command: 
   "\"${TM_RUBY:-ruby}\" \"$TM_BUNDLE_SUPPORT/filename_completion.rb\"\n",
  input: "none",
  keyEquivalent: "^\t",
  name: "Filename Completion",
  output: "insertAsSnippet",
  scope: "source.shell, string.interpolated.ruby",
  uuid: "1932A8DB-9670-4CAD-8269-423AD14ADCE4"},
 {beforeRunningCommand: "nop",
  command: "\"${TM_RUBY:-ruby}\" \"$TM_BUNDLE_SUPPORT/invert_colors.rb\"\n",
  input: "selection",
  name: "Invert HEX Colors",
  output: "replaceSelectedText",
  uuid: "D15DAF9D-80EF-4636-885A-74F64808060A"},
 {beforeRunningCommand: "nop",
  command: "#!/usr/bin/env ruby \nprint \"‹\#{ENV['TM_SELECTED_TEXT']}›\"",
  fallbackInput: "none",
  input: "selection",
  name: "Mark Snippet",
  output: "replaceSelectedText",
  uuid: "56B05535-1ACD-4E55-B9FC-3BC1FAA3DBE1"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\ndef doit!(str='')\n  return str unless ['\"',\"'\",\"`\"].include?(str[0].chr) and str[0] == str[-1]\n  \n  column = (ENV['TM_INPUT_START_COLUMN'].to_i||1) - 1\n  \n  @quote_char = str[0].chr\n  str.gsub!(/\\A\#{Regexp.escape(@quote_char)}|\#{Regexp.escape(@quote_char)}\\Z/,'')\n  strs = []\n  while str.length != 0\n    strs << str.slice!(0..(70-column))\n    column = 0\n  end\n  str = @quote_char + (strs.compact.join %{\#@quote_char + \\n\#@quote_char}) + @quote_char\n  \n  str\nend\n\n# print doit!(%{%{Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. asdjfhakldsfhkladjsfhkalsdjfh}}) #for testing\n\nprint doit!(STDIN.read())\n",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "^q",
  name: "Reformat Long Strings",
  output: "replaceSelectedText",
  scope: "string.quoted.double, string.quoted.single",
  uuid: "93523AF2-7A9D-4190-A1C9-D510AAB690FB"},
 {beforeRunningCommand: "nop",
  command: 
   "{ APP_PATH=$(ps -xwwp $PPID -o command|grep -o '.*.app')\n  osascript -e \"tell app \\\"$(basename \"$APP_PATH\")\\\" to quit\"\n\n  for (( i = 0; i < 50 && $(echo $(ps -xp $PPID|wc -l))-1; i++ )); do\n    sleep .2;\n  done\n\n  if [[ $(ps -xp $PPID|wc -l) -ne 2 ]]; then\n    DYLD_FRAMEWORK_PATH=\"$(find_app org.webkit.nightly.WebKit)/Contents/Resources\" WEBKIT_UNSET_DYLD_FRAMEWORK_PATH=YES \"${APP_PATH}/Contents/MacOS/TextMate\" -WebKitScriptDebuggerEnabled YES -WebKitDeveloperExtras YES\n  else\n    echo >/dev/console \"$(date +%Y-%m-%d\\ %H:%M:%S): TextMate is still running. Relaunch aborted.\"\n  fi\n\n} &>/dev/null &\n",
  input: "none",
  keyEquivalent: "^@q",
  name: "Relaunch TextMate using WebKit",
  output: "discard",
  uuid: "A7B73FB6-4C26-4607-8899-9595D7BF3EB1"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Replace Colors\"\necho '<p>WARNING: Changes you make here are instantly saved to disk. The only way to undo is if you keep the document open in textmate, undo and resave.</p>'\n\"${TM_RUBY:-ruby}\" \"$TM_BUNDLE_SUPPORT/show_hex_colors_and_replace.rb\"\nhtml_footer\n\n",
  input: "selection",
  name: "Replace Hex Colors",
  output: "showAsHTML",
  uuid: "BD115447-20FA-43E3-8694-E8B4280C296B"},
 {beforeRunningCommand: "nop",
  command: "\"${TM_RUBY:-ruby}\" \"$TM_BUNDLE_SUPPORT/replace_colors.rb\"\n",
  fallbackInput: "word",
  input: "selection",
  name: "Replace Selected HEX Color (Every Occurrence)",
  output: "showAsTooltip",
  uuid: "381FFB1B-0CAE-40AC-A228-B575C6E1C1C4"},
 {beforeRunningCommand: "nop",
  bundleUUID: "467B298F-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion\"\npreference = 'CodeCompletions Ruby'\nchoices = []\n\nparsed_choices = TextmateCompletionsParser.new(nil, :scope => :ruby).to_ary\nchoices += parsed_choices if parsed_choices\n\nchoices += ['--']\n\nplist_choices = TextmateCompletionsPlist.new( \"\#{ENV['TM_BUNDLE_PATH']}/Preferences/\#{preference}.tmPreferences\" ).to_ary\nchoices += plist_choices if plist_choices\n\nprint TextmateCodeCompletion.new(choices,STDIN.read).to_snippet\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "~$",
  name: "Ruby Code Completion",
  output: "insertAsSnippet",
  scope: "source.ruby",
  uuid: "FEFA1349-E915-4C5F-A17B-B268D15E92CB"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/ui\"\n\n@THEMES = []\ndef add_themes!(dir)\n  themes = `ls \"\#{dir}\"`.split(\"\\n\")\n  themes.each do |theme|\n    @THEMES << {\n      'title' => theme.gsub('.tmTheme',''),\n      'path'  => '' + dir + theme\n    }\n  end\n  \nend\n\nadd_themes! \"\#{ENV['TM_SUPPORT_PATH']}/../Themes/\"\nadd_themes! \"$HOME/Library/Application Support/TextMate/Themes/\"\n\nselection = TextMate::UI.menu(@THEMES)\n\n`open \"\#{selection['path']}\"`\nprint \"Switched to  \" + selection['title']",
  input: "none",
  keyEquivalent: "^~T",
  name: "Select TextMate Theme",
  output: "showAsTooltip",
  uuid: "B98B3ADE-3EAE-4C7B-BBF4-46258CAD9E76"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Colors\"\n\"${TM_RUBY:-ruby}\" \"$TM_BUNDLE_SUPPORT/show_hex_colors.rb\"\nhtml_footer\n\n",
  input: "selection",
  name: "Show Hex Colors",
  output: "showAsHTML",
  uuid: "7CC7E11B-02BE-4F8D-9E8F-396D2CB74A98"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nMARK = [0xFFFC].pack(\"U\").freeze\ndef snippet_escape (str); str.gsub(/[$`\\\\]/, '\\\\\\\\\\0'); end\n\ndef strip_bracket (txt)\n  if idx = txt.index(/[\\[(\"']/) then\n    chr_map = { ?[ => ?], ?( => ?), ?\" => ?\", ?' => ?' }\n    if ridx = txt.rindex(chr_map[txt[idx]]) then\n      txt[ridx, 1] = \"\"\n      txt[idx, 1] = \"\"\n      txt.insert idx, \" \" if txt[idx - 1, 1] =~ /[^\\[\\]\\(\\)\\{\\}\\s]/ && ENV['TM_SELECTED_TEXT'].nil?\n    end\n  end\n  return txt\nend\n\nline = STDIN.gets\nunless ENV.has_key?('TM_SELECTED_TEXT') then\n  line.insert(ENV['TM_LINE_INDEX'].to_i, MARK)\nend\nprint snippet_escape(strip_bracket(line)).sub(/\#{MARK}/, '${0}')\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "^$\x7F",
  name: "Smart Delete Brackets",
  output: "insertAsSnippet",
  uuid: "AE00FFF1-C436-4826-808A-3AF6C2ABD18B"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes.rb\"\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/ui.rb\"\n\nregex_string = TextMate::UI.request_string(\n  :title => 'Strip Matching Lines', \n  :prompt => 'Regular Expression',\n  :button1 => 'Strip'\n)\n\nTextMate.exit_discard if regex_string.nil?\n\nre = Regexp.new(regex_string)\n$stdin.each_line() do |line|\n\tprint line if !re.match(line)\nend\n",
  fallbackInput: "document",
  input: "selection",
  name: "Strip Matching Lines",
  output: "replaceSelectedText",
  uuid: "A1D725D0-E28F-491C-8776-C6FAF0A89DF7"},
 {beforeRunningCommand: "nop",
  command: 
   "cat <<\"HTML\"\n<style type=\"text/css\">\n   body {\n      font-family: \"Bitstream Vera Sans Mono\", \"Monaco\", monospace;\n   }\n   .comment {\n      font-style: italic;\n      color: #AAA;\n   }\n   .keyword {\n      font-weight: bold;\n   }\n   .string {\n      color: #00F;\n   }\n   .entity {\n      text-decoration: underline;\n   }\n   .storage {\n      color: #888;\n   }\n   .support {\n      color: #0F0;\n   }\n   .constant, .variable {\n      color: #F0F;\n   }\n</style>\n<body>\n<div style=\"white-space: pre; -khtml-line-break: after-white-space;\">\nHTML\n\nperl -pe 's/<\\/[^>]+>/<\\/span>/g' \\\n| perl -pe 's/<([^\\/.>]+)[^>]*>/<span class=\"$1\">/g' \\\n| perl -pe 's/\\t/&nbsp;&nbsp;&nbsp;/g'\n",
  fallbackInput: "document",
  input: "selection",
  inputFormat: "xml",
  keyEquivalent: "",
  name: "View Document as HTML",
  output: "showAsHTML",
  uuid: "BB66B370-D68B-4AFA-A228-C28F34E2AED2"}]
