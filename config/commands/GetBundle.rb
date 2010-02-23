# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "mkdir -p ~/Library/LaunchAgents/\n\ncd ~/Library/Application\\ Support/TextMate/Support\nif [[ $? == 0 ]];\nthen\n svn up . --no-auth-cache --non-interactive\nelse\n mkdir ~/Library/Application\\ Support/TextMate/Support\n svn co http://macromates.com/svn/Bundles/trunk/Support/ ~/Library/Application\\ Support/TextMate/Support --no-auth-cache --non-interactive\nfi\n\n$(cat <<EOF > ~/Library/LaunchAgents/com.macromates.textmate.bundleupdate.plist\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC -//Apple Computer//DTD PLIST 1.0//EN\nhttp://www.apple.com/DTDs/PropertyList-1.0.dtd >\n<plist version=\"1.0\">\n<dict>\n     <key>Label</key>\n     <string>com.macromates.textmate.bundleupdate</string>\n\t <key>Program</key>\n\t <string>$TM_BUNDLE_SUPPORT/bin/autoupdate.sh</string>\n\t <key>RunAtLoad</key>\n\t <true/>\n\t <key>StartCalendarInterval</key>\n\t <dict>  \n\t \t<key>Hour</key>\n\t \t<integer>12</integer>\n\t \t<key>Minute</key>\n\t \t<integer>15</integer>\n\t </dict>\n</dict>\n</plist>\n)\n\n{ launchctl load ~/Library/LaunchAgents/com.macromates.textmate.bundleupdate.plist } &>/dev/console &\n",
  input: "none",
  name: "Install AutoUpdater",
  output: "discard",
  uuid: "A952F27C-2200-4C2C-ABC9-69BD36FF76DF"},
 {command: 
   "\nPTRN=$(ruby -rtextmate -e 'print Dir.entries(TextMate.app_path + \"/Contents/SharedSupport/Bundles\").grep(/.tmbundle$/).join(\"|\")')\nINST=$(ruby -rtextmate -e 'print Dir.entries( File.expand_path(\"~/Library/Application Support/TextMate/Pristine Copy/Bundles\")).grep(/.tmbundle$/).join(\"|\")')\n\nSVN=\"${TM_BUNDLE_SUPPORT}/bin/svn\"\n\nREV=$(< \"$TM_SUPPORT_PATH/version\")\nSVN_OPTS=\"-r$REV --no-auth-cache --non-interactive\"\n\nBASE_URL=http://macromates.com/svn/Bundles/trunk/\n\nbundlelist (){ \n  eval '\"$SVN\"' list \"$SVN_OPTS\" '\"${BASE_URL}/Bundles/\"' \\\n    | egrep -v \"^($PTRN|$INST)/\\$\" \\\n    | egrep -v \"^GetBundle\\.tmbundle\" \\\n    | sed -ne 's/.tmbundle\\/$//p' \\\n    | sort -f \\\n  3> >(CocoaDialog progressbar --indeterminate --title 'Getting Bundle List' --text 'This could take a while...')\n}\nIFS=$'\\n' \nbundle=$(CocoaDialog dropdown \\\n    --title 'Choose a Bundle' \\\n    --text 'Select from list:' \\\n    --button1 Install --button2 Cancel \\\n    --string-output --no-newline \\\n    --items $(bundlelist))\n\nif [[ \"${bundle:0:7}\" == \"Install\" ]];\n  then bu=${bundle:8}\n  else exit_discard\nfi\n\nmkdir -p ~/Library/Application\\ Support/TextMate/Pristine\\ Copy/Bundles\ncd ~/Library/Application\\ Support/TextMate/Pristine\\ Copy/Bundles\n\neval '\"$SVN\"' co \"$SVN_OPTS\" '\"${BASE_URL}/Bundles/${bu}.tmbundle\"' \\\n   2> >(CocoaDialog progressbar --indeterminate --title \"Installing Bundle: ${bu}\" --text 'This could take a while...')\n\nif [[ $? == 0 ]]; then\n  osascript -e 'tell app \"TextMate\" to reload bundles'\n  \"${TM_RUBY:-ruby}\" -wKU \"$TM_BUNDLE_SUPPORT/notify.rb\" installed \"${bu}\"\nfi\n",
  input: "none",
  name: "Install Bundle",
  output: "discard",
  uuid: "19B3B518-4B71-4AD6-BC0B-7B5477ABD2D9"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Installed Bundles\" \"GetBundle\"\nrequire_cmd svnversion\n\ncat <<'HTML'\n  <table class=\"pro_table\" cellspacing=\"0\" cellpadding=\"5\">\n  <tr><th>Bundle Name</th><th>Revision</th></tr>\nHTML\n\ncd ~/Library/Application\\ Support/TextMate/Pristine\\ Copy/Bundles\nfor f in *.tmbundle; do\n  echo \"<tr><td>${f%.tmbundle}</td><td>\"\n  svnversion \"$f\"\n  echo \"</td></tr>\"\ndone\n\ncat <<'HTML'\n  </table>\nHTML\nhtml_footer\n",
  input: "none",
  name: "List Installed Bundles",
  output: "showAsHTML",
  uuid: "FBA5B6EB-2516-4940-9C8B-70645917F8BB"},
 {beforeRunningCommand: "nop",
  command: 
   "JOB=com.macromates.textmate.bundleupdate\nTASK=~/Library/LaunchAgents/$JOB.plist\n\nif [[ -f \"$TASK\" ]]; then\n  launchctl stop \"$JOB\"\n  launchctl unload \"$TASK\"\n  rm \"$TASK\"\n  echo \"Auto updater uninstalled.\"\nelse\n  echo \"Nothing to uninstall.\"\nfi",
  input: "none",
  name: "Remove AutoUpdater",
  output: "showAsTooltip",
  uuid: "E11461A2-B186-4278-9CB9-95AAC8D9D7C0"},
 {beforeRunningCommand: "nop",
  command: 
   "\"${TM_RUBY:-ruby}\" -wKU \"$TM_BUNDLE_SUPPORT/show_bundles.rb\" &>/dev/null &",
  input: "none",
  name: "Show Bundles on Repository",
  output: "showAsTooltip",
  uuid: "8C7398D7-1BC2-4F4D-9BA9-AE1520D764AD"},
 {command: 
   "\nSVN=\"${TM_BUNDLE_SUPPORT}/bin/svn\"\n\nREV=$(< \"$TM_SUPPORT_PATH/version\")\nSVN_OPTS=\"-r$REV --no-auth-cache --non-interactive\"\n\ncd ~/Library/Application\\ Support/TextMate/Pristine\\ Copy/Bundles\nif [[ $? == 0 ]]; then \n  for f in *.tmbundle; do \"$SVN\" up $SVN_OPTS \"$f\"; done \\\n   2> >(CocoaDialog progressbar --indeterminate --title 'Updating all your Bundles' --text 'This could take a while...')\n\n  osascript -e 'tell app \"TextMate\" to reload bundles'\n  \"${TM_RUBY:-ruby}\" -wKU \"$TM_BUNDLE_SUPPORT/notify.rb\" updated\nelse\n  \"${TM_RUBY:-ruby}\" -wKU \"$TM_BUNDLE_SUPPORT/notify.rb\" update_failed\nfi\n",
  name: "Update Installed Bundles",
  output: "discard",
  uuid: "667B3ED4-CA2B-402D-9445-904798AE1AA0"}]
