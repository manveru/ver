# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  bundleUUID: "4675A940-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire ENV['TM_SUPPORT_PATH'] + \"/lib/exit_codes\"\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/escape\"\n\nif ENV['DIALOG'] =~ /2$/\n  require \"\#{ENV['TM_BUNDLE_SUPPORT']}/c_completion2\"\nelse\n  require \"\#{ENV['TM_BUNDLE_SUPPORT']}/c_completion\"\nend\n\nres = CppCompletion.new.print\nprint res",
  fallbackInput: "line",
  input: "none",
  keyEquivalent: "~",
  name: "C  C++ Library Completions",
  output: "insertAsSnippet",
  scope: "source.c++",
  uuid: "093DA4F2-D97F-4309-B869-6970C090A539"},
 {beforeRunningCommand: "nop",
  bundleUUID: "4675A940-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire ENV['TM_SUPPORT_PATH'] + \"/lib/exit_codes\"\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/escape\"\n\nif ENV['DIALOG'] =~ /2$/\n  require \"\#{ENV['TM_BUNDLE_SUPPORT']}/c_completion2\"\nelse\n  require \"\#{ENV['TM_BUNDLE_SUPPORT']}/c_completion\"\nend\n\nres = CCompletion.new.print\nprint res",
  fallbackInput: "line",
  input: "none",
  keyEquivalent: "~",
  name: "C Library Completions",
  output: "insertAsSnippet",
  scope: "source.c",
  uuid: "45FFA4DA-C84A-4D1F-862B-F249C24941EF"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n#\n# Compile the active file to an executable.\n# Executable name is prefixed with \"Test\".\n\nrequire 'English'\n\nFilePath\t\t= ENV['TM_FILEPATH']\nFileDir\t\t= ENV['TM_DIRECTORY']\nFileBaseName\t= File.basename(FilePath)\nFileExtension\t= File.extname(FilePath)\nFileNoExtension = FileBaseName.sub(/\#{FileExtension}$/, \"\")\n\nDir.chdir(ENV['TM_DIRECTORY'])\n\n# have to use g++ to bring in C++ runtime libraries\ncc = case FileExtension\nwhen /\\.c(pp?|xx|\\+\\+)/,'.C','.ii'\n\t'g++'\nelse\n\t'gcc'\nend\n\nputs %x{ \"\#{cc}\" -g -Wmost -Os -o \"Test\#{FileNoExtension}\" \"$TM_FILEPATH\"}\n\nputs \"Successfully created Test\#{FileNoExtension}\" unless $CHILD_STATUS != 0\n",
  input: "none",
  name: "Compile Single File to Tool",
  output: "showAsTooltip",
  scope: "source.c, source.c++",
  uuid: "FF165AAB-1582-4DA8-B0D1-13EBD30B24FD"},
 {beforeRunningCommand: "nop",
  bundleUUID: "4675A940-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nline = STDIN.read\n$tab = (ENV['TM_SOFT_TABS'] == \"NO\" ? \"\\t\" : \" \"*ENV['TM_TAB_SIZE'].to_i )\ndef join_code s\n  # transform // comments to /* */ comments while leaving strings intact\n  s.gsub!(/((['\"])(?:\\\\.|.)*?\\2)|\\/\\*.*?\\*\\/|\\/\\/([^\\n\\r]*)/m) do |line| \n      if $3\n        '/*' + $3.gsub(/\\*\\//, '') + '*/'\n      else\n        line\n      end\n    end\n  print s.split(\"\\n\").map {|line| line.strip}.join(\" \")\nend\n\ndef print_line(line, indent, for_ticker)\n  s = \"\"\n  s = \"\\n\" if for_ticker == 0\n  s + $tab*indent + line # the space should be replaced with soft or hard tab\nend\n\ndef split_code s\n  res = []\n  indent = 0\n  for_ticker = 1\n  # this regexp should not have a capture depth deeper than 1\n  # yes that does rule out backrefs :(\n  s.split(/([\\{\\}\\;]|\"(?:\\\\.|.)*?\"|'(?:\\\\.|.)*?'|\\/\\*.*?\\*\\/|\\/\\/[^\\n\\r]*)/).map do |l|\n    l = l.strip\n    case l\n    when /^for\\s*\\(/\n      res << print_line(l, indent, for_ticker)\n      for_ticker = 5\n    when \"{\"\n      s = print_line(l, indent, for_ticker)\n\t for_ticker -= 1 unless for_ticker == 0\n      indent += 1\n\t  s += print_line(\"\", indent, for_ticker)\n      res << s\n    when \"}\"\n      indent -= 1\n      res << print_line(l, indent, for_ticker)\n      res << print_line(\"\", indent, for_ticker)\n    when \";\"\n      res << l\n      if for_ticker == 0\n        res << print_line(\"\", indent, for_ticker)\n      else\n        res << \" \"\n      end\n    when /^\\s*$/\n\t for_ticker += 1 # if empty string maintain the status-quo\n    else\n      res << l\n    end\n    for_ticker -= 1 unless for_ticker == 0\n  end\n\nrequire \"enumerator\"\nout = []\nres.each_cons(2) do |a,b|\n   # remove empty lines inserted when ; is followed by { or }\n\tout << a unless a.match(/^\\n\\s*$/) && b.match(/^\\n\\s*(\\}|\\{)\\s*$/)\nend\nprint out.join\nend\n\nif line.count(\"\\n\") > 1\n\tjoin_code(line)\nelse\n\tsplit_code(line)\nend\n\n#k = \"- (id)showSomeWindow \n#  {\n#     for(int i =0;i<a;i++)\n#     {\n#       \\\" boras /* */ //\\\"\n#       // hello /* */   \n#       if(a)\n#         [ window makeKeyAndOrderFront:self];\n#       }\n#     }\"\n#join_code(k)\n#l = \"- (id)showSomeWindow { for(int i =0;i<a;i++) { \\\" boras /* */ //\\\" /* hello /*    */ if(a) [ window makeKeyAndOrderFront:self]; } }\"\n#split_code(l)",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "^{",
  name: "Fold/Unfold Code",
  output: "replaceSelectedText",
  scope: "meta.block.c",
  uuid: "3D221F96-F4CC-432D-9A04-F9F4DF3E0F55"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -wKU\n\nline = STDIN.read\n\nif line =~ /\\((.*)\\)(\\s?)/ # extract parameters\n\tline, ws = $1, $2\n\tline.gsub!(/<.*?>/, '')              # remove template args\n\tline.gsub!(/\\(.*?\\)/, '')            # remove (…), e.g. ‘type const& var = type()’\n\tline = line.split(',').map { |e| e.gsub(/.*?(\\w+)(\\s+=.*)?$/, '\\1(\\1)') }.join(', ')\n\tprint ' ' if ws.empty?\n\tprint ': ' + line\nend\n",
  fallbackInput: "line",
  input: "selection",
  name: "Insert Call to Constructors",
  output: "afterSelectedText",
  scope: "source.c++, source.objc++",
  tabTrigger: ":",
  uuid: "1B7326BB-6A85-4ED2-A0D7-51619763D98F"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -wKU\n\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/textmate.rb'\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/ui.rb'\n\nUSR_HEAD  = Regexp.escape \"#include \\\"...\\\" search starts here:\\n\"\nSYS_HEAD  = Regexp.escape \"#include <...> search starts here:\\n\"\nFOOTER    = Regexp.escape 'End of search list.'\n\nCOMPILER  = {\n  'source.c'      => 'gcc 2>&1 >/dev/null -E -v -x c /dev/null',\n  'source.c++'    => 'g++ 2>&1 >/dev/null -E -v -x c++ /dev/null',\n  'source.objc'   => 'gcc 2>&1 >/dev/null -E -v -x objective-c /dev/null',\n  'source.objc++' => 'g++ 2>&1 >/dev/null -E -v -x objective-c++ /dev/null',\n}\n\ndef compiler_search_path(domain = :system)\n  scope        = 'source.c'\n  scope        = $& if ENV['TM_SCOPE'] =~ /source.(obj)?c(\\+\\+)?/\n\n  res = IO.popen(COMPILER[scope]) { |io| io.read }\n  if res =~ /\#{USR_HEAD}(.*)\#{SYS_HEAD}(.*)\#{FOOTER}/m\n    case domain\n      when :system  then $2\n      when :user    then $1 + \" .\\n\"\n      when :all     then $1 + \" .\\n\" + $2\n    end.scan(/ (\\S*)(?: \\(framework directory\\)$)?/).flatten\n  else\n    abort \"Failed to parse compiler output.\\nCommand: \" + COMPILER[scope]\n  end\nend\n\ndef user_search_path(domain = :system)\n  usr = ENV['TM_USR_HEADER_PATH'].to_s\n  sys = ENV['TM_SYS_HEADER_PATH'].to_s\n\n  res = case domain\n    when :system  then sys\n    when :user    then usr\n    when :all     then \"\#{usr}:\#{sys}\"\n  end.split(':')\n  res.delete('')\n\n  res.empty? ? nil : res\nend\n\ndef header\n  if ENV.has_key? 'TM_SELECTED_TEXT'\n    [:all, ENV['TM_SELECTED_TEXT']]\n  elsif ENV['TM_CURRENT_LINE'] =~ /#\\s*(?:include|import)\\s*([<\"])(.*?)[\">]/;\n    [$1 == '<' ? :system : :user, $2]\n  else\n    defaultText = %x{ __CF_USER_TEXT_ENCODING=$UID:0x8000100:0x8000100 /usr/bin/pbpaste -pboard find }\n    header = TextMate::UI.request_string :title => \"Quick Open\", :default => defaultText, :prompt => \"Which header file do you wish to open?\"\n    [:all, header]\n  end\nend\n\ndef find_in_dirs(file, dirs)\n  framework = file.sub(/(.*)\\/(.*\\.h)/, '\\1.framework/Headers/\\2')\n  base = ENV['TM_DIRECTORY'] || Dir.getwd\n  dirs.each do |dir|\n    dir = \"\#{base}/\#{dir}\" unless dir[0..0] == \"/\"\n    return \"\#{dir}/\#{file}\"       if File.exists? \"\#{dir}/\#{file}\"\n    return \"\#{dir}/\#{framework}\"  if File.exists? \"\#{dir}/\#{framework}\"\n  end\n  nil\nend\n\ndef find_recursively(header)\n  hdr_match = /\\b\#{Regexp.escape(header.sub(/(\\.h)?$/, '.h'))}$/i\n  matches   = Dir[\"/System/Library/Frameworks/*.framework/{Frameworks/*.framework/,}Headers/*.h\"].find_all { |e| e =~ hdr_match }\n\n  if matches.size > 1\n    menu = matches.map do |e|\n      header_name = $& if e =~ /[^\\/]+$/\n      framework_suffix = e.scan(/\\/([^\\/]+?).framework/).flatten.join(' → ')\n      { 'path' => e, 'title' => \"\#{header_name} — \#{framework_suffix}\" }\n    end\n    if res = TextMate::UI.menu(menu)\n      res['path']\n    else\n      nil\n    end\n  else\n    matches.first\n  end\nend\n\ndomain, file = header()\nabort if file.nil?\n\ndirs = user_search_path(domain) || compiler_search_path(domain)\nif path = find_in_dirs(file, dirs)\n  TextMate.go_to :file => path\nelsif domain == :all && path = find_recursively(file)\n  TextMate.go_to :file => path\nelse\n  abort \"Unable to find ‘\#{file}’\\nLocations searched:\\n\" + dirs.map { |dir| \"   \#{dir}\" }.join(\"\\n\")\nend\n",
  input: "none",
  keyEquivalent: "@D",
  name: "Quick Open",
  output: "showAsTooltip",
  scope: "source.c, source.objc, source.c++, source.objc++",
  uuid: "FF0E22D6-7D78-11D9-B4DE-000A95A89C98"},
 {autoScrollOutput: true,
  beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/save_current_document\"\n\nmode = ENV[\"TM_SCOPE\"].slice(/.*?\\bsource\\.((?:obj)?c(\\+\\+)?)/, 1)\n\n\ncase mode\nwhen \"c\"\n  g    = \"GCC\"\n  env  = \"C\"\n  ext  = \"c\"\n  lang = \"c\"\nwhen \"c++\"\n  g    = \"GXX\"\n  env  = \"CXX\"\n  ext  = \"cc\"\n  lang = \"c++\"\nwhen \"objc\"\n  g    = \"GCC\"\n  env  = \"OBJC\"\n  ext  = \"m\"\n  lang = \"objective-c\"\nwhen \"objc++\"\n  g    = \"GXX\"\n  env  = \"OBJCXX\"\n  ext  = \"mm\"\n  lang = \"objective-c++\"\nend\n\nTextMate.save_current_document(ext)\nTextMate::Executor.make_project_master_current_document\n\nflags = ENV[\"TM_\#{env}_FLAGS\"] || \"-Wall -include stdio.h \#{\"-include iostream\" unless mode[/c\\+\\+$/].nil?} \#{\"-framework Cocoa\" unless mode[/^obj/].nil?}\"\nargs = [ENV[\"TM_\#{g}\"] || g.downcase.gsub(\"x\", \"+\"), flags + \" -x \#{lang}\", ENV[\"TM_FILEPATH\"]] \n\nTextMate::Executor.run(args, :version_args => [\"--version\"], :version_regex => /\\A([^\\n]*) \\(GCC\\).*/m)\n",
  input: "document",
  keyEquivalent: "@r",
  name: "Run",
  output: "showAsHTML",
  scope: "source.c, source.c++, source.objc, source.objc++",
  uuid: "E823A373-FFD6-42F1-998F-7571A3553847"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nprint case str = STDIN.read\n  when /\\A\"(.*)\"\\z/m then \"<\" + $1 + \">\"\n  when /\\A<(.*)>\\z/m then '\"' + $1 + '\"'\n  else str\nend\n",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "^\"",
  name: "Toggle System/Local Include",
  output: "replaceSelectedText",
  scope: "string.quoted.double.include.c, string.quoted.other.lt-gt.include.c",
  uuid: "E8D80809-0CDE-4E57-AC2A-8C22DFF353EE"}]
