# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib/doctohtml.rb\"\nprint generate_stylesheet_from_theme()",
  input: "none",
  inputFormat: "xml",
  keyEquivalent: "",
  name: "Create CSS From Current Theme",
  output: "openAsNewDocument",
  uuid: "ED204720-38FC-427C-B91E-D6AE866DAE3A"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -rjcode -Ku\nrequire \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib/doctohtml.rb\"\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb\"\nunit = ENV.has_key?('TM_SELECTED_TEXT') ? 'selection' : 'document'\nTextMate.call_with_progress(:message => \"Creating HTML version of \#{unit}…\") do\n  print document_to_html( STDIN.read, :include_css => !ENV.has_key?('TM_SELECTED_TEXT') )\nend\n",
  input: "selection",
  inputFormat: "xml",
  name: "Create HTML From Document / Selection",
  output: "openAsNewDocument",
  uuid: "950B3108-E2E3-414E-9C4C-EE068F59A895"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -rjcode -Ku\nrequire \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib/doctohtml.rb\"\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb\"\nunit = ENV.has_key?('TM_SELECTED_TEXT') ? 'selection' : 'document'\nTextMate.call_with_progress(:message => \"Creating HTML version of \#{unit}…\") do\n  print document_to_html( STDIN.read, { :line_numbers => true, :include_css => !ENV.has_key?('TM_SELECTED_TEXT') } )\nend",
  input: "selection",
  inputFormat: "xml",
  name: "Create HTML From Document / Selection With Line Numbers",
  output: "openAsNewDocument",
  uuid: "7AE6F783-F162-4063-850D-1441441849D8"},
 {beforeRunningCommand: "nop",
  command: 
   "FILE=\"$HOME/Library/Preferences/com.macromates.edit_in_textmate.plist\"\n[ -e \"$FILE\" ] || cat <<'PLIST' >\"$FILE\"; mate \"$FILE\"\n{\n\tURLAssociations = {\n\t\t'mail.google.com/' = 'mail';\n\t\t'macromates.com/blog/' = 'markdown';\n\t\t'blacktree.cocoaforge.com/forums/' = 'bbcode';\n\t};\n}\n/*\n\tCustom associations used by the Edit in TextMate service when\n\tinvoked from a WebKit-based browser (e.g. Safari or OmniWeb)\n\n\tProvide an URL subset and the extension to use for the temporary\n\tfile when this subset is found in the URL from the calling\n\tapplications current page.\n\n\tThis is to trigger proper syntax highlight.\n\t\n\tIn case of multiple subsets matching the URL, the longest one\n\twill win.\n\n*/\nPLIST",
  input: "none",
  name: "Edit in TextMate URL Associations",
  output: "showAsTooltip",
  uuid: "4981F52A-F663-45FC-AE25-EE211E88BA05"},
 {beforeRunningCommand: "nop",
  command: "open \"http://macromates.com/ticket/show?ticket_id=$(cat)\"",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "",
  name: "Go to Ticket",
  output: "discard",
  scope: "constant.numeric.ticket.release-notes",
  uuid: "F10674C0-D55D-4EFD-88DE-DC60C3EE6562"},
 {beforeRunningCommand: "nop",
  command: 
   "# This shortcut can crash under Leopard, so blocking\n# out the shortcut for now\n\necho \"WARNING: On Leopard the menu item searching is prone to crashing, so we\nhave disabled the key equivalent. Sorry about the inconvenience.\"",
  input: "none",
  keyEquivalent: "@?",
  name: "Help Menu Crash Preventer",
  output: "showAsTooltip",
  uuid: "89CFAC75-FF44-4106-8168-475E685D2018"},
 {beforeRunningCommand: "nop",
  command: "cat ${TMP:-/tmp}/TextMate-ScratchSnippet.txt",
  input: "none",
  keyEquivalent: "~S",
  name: "Insert Scratch Snippet",
  output: "insertAsSnippet",
  uuid: "ADFED53B-16EC-4956-A6A7-3EA2B8140F86"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Install “Edit in TextMate…”\"\n\n# javascript which creates the link (by calling out to the shell)\ncat <<HTML\n<script>\nfunction installInputManager () {\n  var cmd = TextMate.system('install_edit_in_tm.sh', null);\n  var res = document.getElementById(\"result\");\n  res.innerHTML = \"<p>\" + cmd.outputString + \"</p>\";\n}\n</script>\nHTML\n\n# documentation which links to the script above\n\"$TM_SUPPORT_PATH/lib/markdown_to_help.rb\" <<\"MARKDOWN\"\n# Intro\n\nIncluded with TextMate is an input manager which can add an “Edit in TextMate” menu item to the Edit menu of other applications.\n\nThis allow you to call upon TextMate to edit the text in the current web form (Safari) or current letter that you are writing (Mail) by pressing &#x2303;&#x2318;E and when done editing the text in TextMate, press &#x2318;S + &#x2318;W to save, close, and have focus (plus edited text) return to the application from which you invoked the Edit in TextMate action.\n\n\n# Installation\n\nThe Input Manager is preferably installed by creating a symbolic link in `~/Library/InputManagers` which point to the location of the input manager (inside the TextMate application bundle).\n\nYou can create this link by using the button below. **Note for Leopard users:** The script requires you to enter an administrator password to install the Input Manager (see [this post](http://blog.macromates.com/2007/inputmanagers-on-leopard/))\n\n<div id=\"result\"><input type=\"Button\" value=\"Create Symbolic Link\" onClick=\"installInputManager();\"></div>\n\n_After creating the link you need to relaunch the applications in which you want to test the functionality (e.g. Mail, Safari, …)_\n\n\n# Excluding Applications\n\nIf you do not want the menu item to appear in a certain application, you can set the `DisableEditInTextMateMenuItem` defaults key to `1` for that application.\n\nFor example to disable the menu item for `Console` we would do:\n\n\tdefaults write -app Console DisableEditInTextMateMenuItem 1  \n\nWe can also disable it for all applications using:\n\n\tdefaults write NSGlobalDomain DisableEditInTextMateMenuItem 1   \n\n\n# File Type Mapping\n\nWhen you initiate editing from an application, the temporary file used will have the application name as extension. For example if you call it from Mail then the extension will be `mail`. Based on this, TextMate will pick the proper language grammar, and if not, you can correct it, which will then stick to that extension.\n\nWhen you call it from a browser, the URL of the page is often indicative of the type you will be editing, for example if the URL is <http://macromates.com/blog/> then you are most likely editing a comment on the blog, which is in Markdown, thus TextMate should pick that syntax.\n\nFor this reason, the service reads a configuration file which maps URL fragments to a file extension that will be used for the temporary file. This only works for WebKit based browsers (e.g. OmniWeb and Safari).\n\nThe file is read as:\n\n\t~/Library/Preferences/com.macromates.edit_in_textmate.plist\n\nHere is an example file:\n\n    {  URLAssociations = {\n          'mail.google.com/'                  = mail;\n          'macromates.com/blog/'              = markdown;\n          'macromates.com/wiki/'              = markdown;\n          'blacktree.cocoaforge.com/forums/'  = bbcode;\n       };\n    }\n\nIf multiple URL fragments match the current URL, the longest match wins.\n\n\n# Custom Key Bindings\n\nYou can use System Preferences &#x2192; Keyboard & Mouse to change the default key equivalent. This however only works as long as the key binding includes the command modifier (&#x2318;). If you want to give it a key that does not include this modifier, you can add an entry to your `~/Library/KeyBindings/DefaultKeyBinding.dict` with the action method set to `editInTextMate:`. With this key binding, you do not need to have the menu item (so you can disable that in the global domain).\n\nFor example I have the following line in my `DefaultKeyBinding.dict`:\n\n\t\"^E\" = \"editInTextMate:\";\n\nThis puts the action on &#x2303;&#x21E7;E.\n\n\n# Compatibility\n\nThe input manager works by adding a category to `NSTextView` and `WebView` (which is used by Mail to edit text). So it will only work for Cocoa applications (and those which use these controls).\n\nPreviously the functionality was provided by a Service, but the synchronous nature of services, and the need to select text first, made it less than ideal.\n\nGenerally the input manager approach works better, but it is a hack, so e.g. if you call upon the Edit in TextMate action and close the window which held the text, or was calling the service from the field editors text view and advance focus, before the text has been returned, do not be surprised if the text does not show up in the proper text view.\n\nThat said, it should be rather robust, and you can even call “Edit in TextMate” from within TextMate (in its Cocoa text views used e.g. in the Bundle Editor).\n\n\n# Source Code\n\nThe source code for the input manager is available here: <http://macromates.com/svn/Bundles/trunk/Tools/Edit%20in%20TextMate/>\n\nMARKDOWN\n\nhtml_footer",
  input: "none",
  name: "Install “Edit in TextMate”…",
  output: "showAsHTML",
  uuid: "61F92184-1A50-4310-9F75-C9CD2C8819FA"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -rjcode -KU\n\nBUNDLE_SUPPORT = ENV['TM_BUNDLE_SUPPORT']\nSUPPORT_PATH = ENV['TM_SUPPORT_PATH']\n\nPASTE_URL = ENV['TM_PASTIE_URL'] || 'http://pastie.textmate.org/pastes'\n\nrequire \"\#{BUNDLE_SUPPORT}/lib/doctohtml.rb\"\nrequire \"\#{SUPPORT_PATH}/lib/textmate\"\nrequire \"\#{SUPPORT_PATH}/lib/tm/detach\"\nrequire \"\#{SUPPORT_PATH}/lib/progress\"\nrequire \"\#{SUPPORT_PATH}/lib/escape\"\nrequire 'cgi'\nrequire 'fileutils'\nrequire 'zlib'\nrequire \"yaml\"\nrequire \"iconv\"\nrequire \"tempfile\"\n\ndef temp_script(script)\n  dest = %x{ /usr/bin/mktemp -t tm_paste }.chomp\n  at_exit { File.delete dest }\n  FileUtils.cp(script, dest)\n  dest\nend\n\n# example: [\"Colloquy\", \"#textmate\"] -> [ 2, 1 ]\ndef indices_for_names(names, tree)\n  name = names.shift\n  node = tree.find { |n| n[\"name\"] == name }\n  return [ 0 ] if node.nil?\n  res  = [ tree.index(node) ]\n  res += indices_for_names(names, node[\"children\"]) unless names.empty? || node[\"children\"].nil?\n  return res\nend\n\n# example: [ 2, 1 ] -> [\"Colloquy\", \"#textmate\"]\ndef names_for_indices(indices, tree)\n  node = tree[indices.shift.to_i]\n  res  = [ node[\"name\"] ]\n  res += names_for_indices(indices, node[\"children\"]) unless indices.empty?\n  return res\nend\n\nPREFS_FILE = \"\#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.paste_online.yaml\"\n\ndef load_prefs(destinations)\n  prefs = File.open(PREFS_FILE) { |file| YAML.load(file) } rescue { }\n  selected = prefs['selectedDestinations'] || [ [ \"Paste to Colloquy:\", \"#textmate\" ] ]\n  selected.collect! { |names| indices_for_names(names, destinations) }\n  return { 'selectedDestinations' => selected }\nend\n\ndef save_prefs(params)\n  selected = params['selectedDestinations'].dup\n  selected.collect! { |indices| names_for_indices(indices.dup, params['destinations']) }\n  File.open(PREFS_FILE, \"w\") { |file| YAML.dump({ 'selectedDestinations' => selected }, file) }\nend\n\ndef get_destinations\n  destinations = []\n  node = nil\n\n  actions = %x{ osascript \#{e_sh temp_script(BUNDLE_SUPPORT + \"/get_destinations.scpt\")} }\n  actions.split(\"\\n\").each do |action|\n    if action =~ /^\\t(.+)/ then\n      (node['children'] ||= [ ]) << { 'name' => $1 }\n    else\n      node = { 'name' => action }\n      destinations << node\n    end\n  end\n\n  destinations.sort! { |a, b| a['name'] <=> b['name'] }\n  destinations.each { |e| e['children'].sort! { |a, b| a['name'] <=> b['name'] } if e.has_key? 'children' }\n\n  prefs = load_prefs(destinations)\n\n  window_title = if ENV.has_key? 'TM_SELECTED_TEXT'; 'Paste Selection Online'; else 'Paste Document Online'; end\n  default_wrap = (ENV['TM_SCOPE'] =~ /^text\\./) ? 1 : 0\n  parameters = {\n    'windowTitle'           => window_title,\n    'destinations'          => destinations,\n    'selectedDestinations'  => prefs['selectedDestinations'],\n    'private'               => true,\n    'lineWrap'              => default_wrap,\n  }.to_plist\n\n  res = %x{ \"$DIALOG\" -cmp \#{e_sh parameters} pastebin }\n  exit if $? != 0\n\n  res = OSX::PropertyList.load(res)\n  exit unless res.has_key? 'returnCode'\n\n  save_prefs(res)\n\n  actions = []\n  res['selectedDestinations'].to_a.each do |index_array|\n    path = []\n    node = destinations\n    index_array.each do |index|\n      path << node[index.to_i]['name']\n      node = node[index.to_i]['children']\n    end\n    actions << path.join(' ')\n  end\n\n  [ actions.join(\"\\n\"), res['private'], res['lineWrap'] ]\nend\n\nTM_APP_PATH = TextMate.app_path\n\ndef find_language_ext\n\tbundle_dirs = [\n\t\tFile.expand_path('~/Library/Application Support/TextMate/Bundles'),\n\t\t'/Library/Application Support/TextMate/Bundles',\n\t\tTM_APP_PATH + '/Contents/SharedSupport/Bundles'\n\t]\n\n  if scope = ENV['TM_SCOPE'] then\n    scope = scope.split(' ').first\n    bundle_dirs.each do |dir|\n      Dir.glob(dir + '/*.tmbundle/Syntaxes/*.{plist,tmLanguage}') do |filename|\n        File.open(filename) do |io|\n          begin\n            plist = OSX::PropertyList.load(io)\n            if scope == plist['scopeName'].to_s then\n              return Array(plist['fileTypes']).first || 'txt'\n            end\n          rescue Exception => e\n            abort \"Error while parsing “\#{filename}”\\n\\n\#{e}\"\n          end\n        end\n      end\n    end\n  end\n\n  ext = File.extname(ENV['TM_FILENAME'].to_s).sub(/\\A\\./, '')\n  ext.empty? ? 'txt' : ext\nend\n\ndef strip_leading(text, ch = ' ')\n  count = text.gsub(/<[^>]+>/, '').split(\"\\n\").map { |e| e =~ /^\#{ch}*(?!\#{ch}|$)/ ? $&.length : nil }.reject { |e| e.nil? }.min\n  text.send(text.respond_to?(:lines) ? :lines : :to_s).map { |line| count.times { line.sub!(/^((<[^>]+>)*)\#{ch}/, '\\1') }; line }.join\nend\n\nURL_REGEXP = %r{\n      \\A(https?://)                             # scheme\n      ([0-9a-z_!~*\\'()-]+\\.)*                   # tertiary domain(s) -- e.g. www. \n      ([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.      # second level domain \n      ([a-z]{2,6})                              # first level domain -- e.g. .com or .museum \n      (:[0-9]{1,4})?                            # port number -- e.g. :80 \n      ((/?)|                                    # a slash isn’t required if there is no file name \n      (/[0-9a-z_!~*\\'().;?:@&=+$,%#-]+)+/?)\\z   # path\n  }xi\n\ndef connect_to_server(name, url, *args)\n  $status, res = :unknown, nil\n\n  server = $1 if url =~ %r{.*?://(.*?)(/.*)?$}\n  TextMate.call_with_progress(:title => \"Paste to \#{name}\", :message => \"Contacting Host “\#{server}”…\", :cancel => lambda { $status = :cancel; Process.kill(\"INT\", -Process.pid) }) do\n    thr = Thread.new { sleep 60.0; $status = :timeout; Process.kill(\"INT\", -Process.pid) rescue nil }\n\n    oldpgid = Process.getpgid(0)\n    Process.setpgid(0, 0)\n    rd, wr = IO.pipe\n    pid = fork do\n      STDOUT.reopen(wr)\n      rd.close\n      exec('curl', url, '-sLo/dev/null', '-w%{url_effective}', *args)\n    end\n    Process.setpgid(0, oldpgid)\n    wr.close\n    res = rd.read\n    Process.wait(pid)\n\n    $status = :success if $?.exitstatus == 0 && $status == :unknown\n\n    thr.kill unless $status == :timeout\n    thr.join\n  end\n\n  $status = :error if res !~ URL_REGEXP || res == url # pastie returns the initial URL on some errors\n  return $status, res\nend\n\ndef paste_stdin(priv, wrap)\n  xml       = STDIN.read\n\n  text_file = Tempfile.new('tm_paste_text')\n  html_file = Tempfile.new('tm_paste_html')\n\n  text_file << CGI::unescapeHTML(xml.gsub(/<[^>]*>/, ''))\n  text_file.close\n\n  gz = Zlib::GzipWriter.new(html_file)\n  gz.write(document_to_html(strip_leading(strip_leading(xml, \" \"), \"\\t\")))\n  gz.close\n  html_file.close\n\n  author = ENV['TM_AUTHOR'] || \"\#{ENV['TM_FULLNAME']} (\#{ENV['USER']})\"\n  ext    = find_language_ext\n\n  start_time   = Time.now\n  $status, res = connect_to_server(\"Pastie\", PASTE_URL,\n    \"-HExpect:\",\n    \"-Fpaste[parser]=plaintext\",\n    \"-Fpaste[restricted]=\#{priv}\",\n    \"-Fpaste[wrap]=\#{wrap}\",\n    \"-Fpaste[display_name]=\#{author}\",\n    \"-Fpaste[file_extension]=\#{ext}\",\n    \"-Fpaste[body]=<\#{text_file.path}\",\n    \"-Fpaste[textmate_html_gz]=<\#{html_file.path}\"\n  )\n\n  open(File.expand_path('~/Library/Logs/Pastie.log'), 'a') do |io|\n    amount       = (File.size(text_file.path) + File.size(html_file.path)).to_s.gsub(/\\d{1,3}(?=(\\d{3})+(?!\\d))/, '\\0,') + \" bytes\"\n    time_elapsed = '%.1f seconds' % (Time.now - start_time)\n    io << start_time.strftime('%F %T %Z: ') <<\n      case $status\n        when :timeout then \"Timeout pasting \#{amount} after \#{time_elapsed}\\n\"\n        when :cancel  then \"User cancelled pasting of \#{amount} after \#{time_elapsed}\\n\"\n        when :error   then \"Unknown error after \#{time_elapsed} pasting \#{amount}\\n\"\n        else           \"Pasted \#{amount} in \#{time_elapsed}: \#{res}\\n\"\n      end\n  end\n\n  paste_via_rafb = \n  case $status\n    when :timeout then TextMate::UI.alert(:warning, \"Timeout Pasting\", \"There was a problem pasting your text (timeout).\\nWould you like to use RAFB.net instead?\", \"Paste via RAFB\", \"Cancel\") != \"Cancel\"\n    when :error   then TextMate::UI.alert(:warning, \"Error Pasting\", \"There was a problem pasting your text (unknown).\\nWould you like to use RAFB.net instead?\", \"Paste via RAFB\", \"Cancel\") != \"Cancel\"\n    else false\n  end\n\n  if paste_via_rafb\n    mode = $& if ENV['TM_MODE'] =~ /^(C89|C|C\\+\\+|C#|Java|Pascal|Perl|PHP|PL\\/I|Python|Ruby|SQL|VB)$/\n    $status, res = connect_to_server(\"RAFB.net\", \"http://rafb.net/paste/paste.php\",\n      \"-Fnick=\#{ENV['USER']}\",\n      \"-Fcvt_tabs=\#{ENV['TM_TAB_SIZE']}\",\n      \"-Ftext=<\#{text_file.path}\",\n      \"-Flang=\#{mode || \"Plain Text\"}\"\n    )\n  end\n\n  return $status == :success ? res : nil\nend\n\nTextMate.detach {\n  dests, priv, wrap = get_destinations\n  unless dests.empty?\n    if url = paste_stdin(priv, wrap)\n      dests = Iconv.iconv('mac', 'utf-8', dests) if %x{ defaults read /System/Library/CoreServices/SystemVersion ProductVersion } =~ /\\A10\\.4/\n      %x{ osascript \#{e_sh temp_script(BUNDLE_SUPPORT + \"/paste_to_destinations.scpt\")} \#{e_sh url} \#{e_sh dests} }\n    end\n  end\n}\n",
  fallbackInput: "document",
  input: "selection",
  inputFormat: "xml",
  keyEquivalent: "^~V",
  name: "Paste Document / Selection Online…",
  output: "discard",
  uuid: "6E779E48-F146-49BF-B60C-EFDFD1380772"},
 {beforeRunningCommand: "nop",
  command: "cat > ${TMP:-/tmp}/TextMate-ScratchSnippet.txt",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "^~s",
  name: "Record Scratch Snippet",
  output: "discard",
  uuid: "5F225755-5840-44CF-BC26-2D484DE833A0"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/bin/sh\n\n{ osascript -e \"tell app \\\"$(basename \"$TM_APP_PATH\")\\\" to quit\"\n\n  while ps >/dev/null -xp \"$PPID\"; do\n    if (( ++n == 10 )); then\n      \"$DIALOG\" </dev/null alert --title \"Relaunch Timed Out\" --body \"Unable to exit TextMate.\" --button1 OK\n      exit\n    fi\n    sleep .2;\n  done\n\n  open \"$TM_APP_PATH\"\n\n} &>/dev/null &",
  input: "none",
  keyEquivalent: "^@q",
  name: "Relaunch TextMate",
  output: "discard",
  uuid: "E5142394-B07A-11D9-8EC4-000D93589AF6"},
 {beforeRunningCommand: "nop",
  command: 
   "\"${TM_RUBY:=ruby}\" -- \"${TM_BUNDLE_SUPPORT}/bin/list_shortcuts.rb\"",
  dontFollowNewOutput: true,
  input: "none",
  keyEquivalent: "^~@k",
  name: "Show Keyboard Shortcuts",
  output: "showAsHTML",
  uuid: "970BA294-B667-11D9-8D53-00039369B986"}]
