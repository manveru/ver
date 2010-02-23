# Encoding: UTF-8

[{beforeRunningCommand: "saveModifiedFiles",
  command: 
   "# TM_IGNORE_WARNINGS is a sequence of glob patterns of files in which to ignore\n# warnings.  Right now it doesn't support escaped ':\" -- the separator character.\n# export TM_IGNORE_WARNINGS=\"mitchcode_*.h:*/MitchCode/*\"\n\n# Look at other bundles to see if there are conventions for using 'defaults'.\nPREF_DOMAIN=com.macromates.textmate.scons_prefs\nlastTarget=`defaults read ${PREF_DOMAIN} last_target`\n\nres=$(CocoaDialog inputbox --title \"Target\" \\\n    --informative-text \"Build Target:\" \\\n    --text \"${lastTarget}\" \\\n    --button1 \"Build\" --button2 \"Cancel\")\n\n[[ $(head -n1 <<<\"$res\") == \"2\" ]] && exit_discard\n\ntarget=\"\"\nreslines=`(wc -l <<<\"$res\")|sed -e 's/ //g'`\n[[ \"${reslines}\" == \"2\" ]] && target=$(tail -n1 <<<\"$res\")\n\ndefaults write ${PREF_DOMAIN} last_target -string \"${target}\"\ndefaults write ${PREF_DOMAIN} last_build_dir -string \"${TM_DIRECTORY}\"\n\n# Allow spaces to delimit arguments in ${target} -- bad idea?\npython -u \"${TM_BUNDLE_SUPPORT}/bin/scons_html_wrapper.py\" ${target}",
  fallbackInput: "word",
  input: "none",
  keyEquivalent: "@b",
  name: "Build ...",
  output: "showAsHTML",
  scope: 
   "source.c, source.objc, source.c++, source.objc++, source.python, source.d",
  uuid: "88F36C61-F809-4FCE-97AF-D36019891F31"},
 {beforeRunningCommand: "saveModifiedFiles",
  command: 
   "# TM_IGNORE_WARNINGS is a sequence of glob patterns of files in which to ignore\n# warnings.  Right now it doesn't support escaped ':\" -- the separator character.\n# export TM_IGNORE_WARNINGS=\"mitchcode_*.h:*/MitchCode/*\"\n\n# Look at other bundles to see if there are conventions for using 'defaults'.\nPREF_DOMAIN=com.macromates.textmate.scons_prefs\nlastTarget=`defaults read ${PREF_DOMAIN} last_target 2>/dev/null`\nlastBuildDir=`defaults read ${PREF_DOMAIN} last_build_dir 2>/dev/null`\n\nif [ \"x$lastBuildDir\" != \"x\" ]; then\n    cd ${lastBuildDir}\nfi\n\n# Allow spaces to delimit arguments in ${target} -- bad idea?\npython -u \"${TM_BUNDLE_SUPPORT}/bin/scons_html_wrapper.py\" ${lastTarget}",
  fallbackInput: "word",
  input: "none",
  keyEquivalent: "@b",
  name: "Rebuild",
  output: "showAsHTML",
  scope: 
   "source.c, source.objc, source.c++, source.objc++, source.python, source.d",
  uuid: "2CDB078C-78E9-4DDA-9DF9-6F18D1E92BAE"}]
