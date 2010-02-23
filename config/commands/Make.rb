# Encoding: UTF-8

[{autoScrollOutput: true,
  beforeRunningCommand: "saveModifiedFiles",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/save_current_document\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/escape\"\n\nTextMate::Executor.make_project_master_current_document\n\nDir.chdir(ENV[\"TM_PROJECT_DIRECTORY\"])\nENV[\"TM_MAKE_FILE\"] = ENV[\"TM_PROJECT_DIRECTORY\"] + \"/Makefile\" if ENV[\"TM_MAKE_FILE\"].nil? or not File.file?(ENV[\"TM_MAKE_FILE\"])\n\nflags = [\"-w\"]\nflags << \"-f\" + File.basename(ENV[\"TM_MAKE_FILE\"])\nflags << ENV[\"TM_MAKE_FLAGS\"] unless ENV[\"TM_MAKE_FLAGS\"].nil?\nflags << ENV[\"TM_MAKE_TARGET\"] unless ENV[\"TM_MAKE_TARGET\"].nil?\n\nENV[\"TM_DISPLAYNAME\"] = ENV[\"TM_MAKE_TARGET\"].nil? ? \"default\" : ENV[\"TM_MAKE_TARGET\"]\n\nDir.chdir(File.dirname(ENV[\"TM_MAKE_FILE\"]))\n\ndirs = [ENV['TM_PROJECT_DIRECTORY']]\nTextMate::Executor.run(\"make\", flags, :verb => \"Making\") do |line, type|\n  if line =~ /^make.*?: Entering directory `(.*?)'$/ and not $1.nil? and File.directory?($1)\n    dirs.unshift($1)\n    \"\"\n  elsif line =~ /^make.*?: Leaving directory `(.*?)'$/ and not $1.nil? and File.directory?($1)\n    dirs.delete($1)\n    \"\"\n  elsif line =~ /^(.*?):(?:(\\d+):)?\\s*(.*?)$/ and not $1.nil?\n    expanded_path = dirs.map{ |dir| File.expand_path($1, dir) }.find{ |path| File.file?path }\n    if !expanded_path.nil?\n      \"<a href=\\\"txmt://open?url=file://\#{e_url expanded_path}\#{$2.nil? ? '' : \"&line=\" + $2}\\\">\#{htmlize $3}</a><br>\\n\"\n    end\n  end\nend\n",
  input: "document",
  keyEquivalent: "@b",
  name: "Build",
  output: "showAsHTML",
  uuid: "19F9C045-7BCC-429B-8C68-967B6BD15B84"},
 {autoScrollOutput: true,
  beforeRunningCommand: "saveModifiedFiles",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/save_current_document\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/ui\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/exit_codes\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/escape\"\n\nTextMate::Executor.make_project_master_current_document\n\nDir.chdir(ENV[\"TM_PROJECT_DIRECTORY\"])\nENV[\"TM_MAKE_FILE\"] = ENV[\"TM_PROJECT_DIRECTORY\"] + \"/Makefile\" if ENV[\"TM_MAKE_FILE\"].nil? or not File.file?(ENV[\"TM_MAKE_FILE\"])\n\nflags = [\"-w\"]\nflags << \"-f\" + File.basename(ENV[\"TM_MAKE_FILE\"])\nflags << ENV[\"TM_MAKE_FLAGS\"] unless ENV[\"TM_MAKE_FLAGS\"].nil?\n\ntargets = `make -np|grep -B1 PHONY|grep -Ev '^(#|--|\\\\.)'|grep -Eo '^[^:]+'|sort -f`.split.collect{|t| {\"title\" => t} }\nselection = TextMate::UI.menu(targets)\n\nTextMate::exit_discard if selection == nil\nENV[\"TM_MAKE_TARGET\"] = selection['title']\n\nflags << ENV[\"TM_MAKE_TARGET\"] unless ENV[\"TM_MAKE_TARGET\"].nil?\n\nENV[\"TM_DISPLAYNAME\"] = ENV[\"TM_MAKE_TARGET\"].nil? ? \"default\" : ENV[\"TM_MAKE_TARGET\"]\n\nDir.chdir(File.dirname(ENV[\"TM_MAKE_FILE\"]))\n\ndirs = [ENV['TM_PROJECT_DIRECTORY']]\nTextMate::Executor.run(\"make\", flags, :verb => \"Making\") do |line, type|\n  if line =~ /^make.*?: Entering directory `(.*?)'$/ and not $1.nil? and File.directory?($1)\n    dirs.unshift($1)\n    \"\"\n  elsif line =~ /^make.*?: Leaving directory `(.*?)'$/ and not $1.nil? and File.directory?($1)\n    dirs.delete($1)\n    \"\"\n  elsif line =~ /^(.*?):(?:(\\d+):)?\\s*(.*?)$/ and not $1.nil?\n    expanded_path = dirs.map{ |dir| File.expand_path($1, dir) }.find{ |path| File.file?path }\n    if !expanded_path.nil?\n      \"<a href=\\\"txmt://open?url=file://\#{e_url expanded_path}\#{$2.nil? ? '' : \"&line=\" + $2}\\\">\#{htmlize $3}</a><br>\\n\"\n    end\n  end\nend\n",
  input: "document",
  keyEquivalent: "~@b",
  name: "Build Target…",
  output: "showAsHTML",
  uuid: "6E5653CE-68E0-42E5-BF29-B3AB323BC218"}]
