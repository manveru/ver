# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  bundleUUID: "0B296803-7D51-11D9-859D-000D93B6E43C",
  command: 
   "#!/usr/bin/env bash\n\n. \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"TODO Bundle Help\" \"TODO\"\n\n\"$TM_SUPPORT_PATH/lib/markdown_to_help.rb\" <<'MARKDOWN'\n\n# Introduction\n\nThe \"Show TODO List\" command will scan your current document (on disk) or documents in your project for lines containing certain tags (see below).\nYou will be presented with a row of “Tabs” that are counting matches while the search is going on. Once the search finishes a list for each of the tags and their context is shown. Each entry can be clicked to jump to that line in that file. The lists can be ordered by clicking on their column titles. Clicking on the Tabs will jump to the corresponding list.\n\nTextMate will ignore files whose full path matches the regular expression defined by the environment variable `TM_TODO_IGNORE`.\n\nNote: This command requires Ruby 1.8\n\n# Tags\n\nPreconfigured tags are:\n\n* <span style=\"color: #A00000;\">FIXME (or FIX ME)</span>\n* <span style=\"color: #CF830D;\">TODO</span>\n* <span style=\"color: #008000;\">CHANGED</span>\n* <span style=\"color: #0090C8;\">RADAR (as &lt;radar://…&gt; or &lt;rdar://…&gt;)</span>\n\nThose tags can easily be set up via the <span onClick=\"TextMate.system(&apos;&quot;${TM_RUBY:-ruby}&quot; &quot;$TM_BUNDLE_SUPPORT/lib/settings.rb&quot; &amp;&gt;/dev/null &amp;&apos;, null)\">“Preferences”</a> command.\n\n# Hints\n\n* The list can be printed using _Print…_ (⌘P) from the _File_ menu.\n* The Command will abort when the project directory resolves to the root folder.\n* Access keys: `⌃` + first letter of the tag (like `⌃T` for “TODO”) will jump to the respective section.\n\nMARKDOWN\n\nhtml_footer\n",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  uuid: "46C3E5A1-7E04-11D9-AE69-000D93B6E43C"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -wKU\nrequire ENV['TM_SUPPORT_PATH'] + '/lib/escape.rb'\n\n10.times do |n|\n  start = ENV[\"TM_COMMENT_START\#{\"_\#{n}\" if n > 0}\"].to_s.strip\n  stop  = ENV[\"TM_COMMENT_END\#{\"_\#{n}\"   if n > 0}\"].to_s.strip\n  unless start.empty? || stop.empty?\n    print \"\#{e_sn start}\\n\\tTODO $0\\n\#{e_sn stop}\"\n    exit\n  end\nend\n\nfallback = ENV['TM_COMMENT_START'].to_s.strip\nprint \"\#{e_sn fallback.sub(/.$/, '\\\\0 ')}TODO \"\n",
  input: "none",
  name: "Insert TODO List",
  output: "insertAsSnippet",
  tabTrigger: "todo",
  uuid: "D2F7F545-5149-47B9-AC62-DBDC6ACAB9BB"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby -wKU\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/tm/detach\"\nrequire \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib/settings.rb\"\nTextMate.detach { Settings.show_ui }\n",
  input: "none",
  name: "Preferences…",
  output: "showAsTooltip",
  uuid: "65C4098C-BB16-4CA1-9297-B312BCD0433F"},
 {beforeRunningCommand: "saveModifiedFiles",
  command: "\"${TM_RUBY:-ruby}\" -r \"$TM_BUNDLE_SUPPORT/todo.rb\"",
  input: "none",
  keyEquivalent: "^T",
  name: "Show TODO List",
  output: "showAsHTML",
  uuid: "14C1643E-7D51-11D9-859D-000D93B6E43C"}]
