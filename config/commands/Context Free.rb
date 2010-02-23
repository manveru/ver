# Encoding: UTF-8

[{autoScrollOutput: true,
  beforeRunningCommand: "saveActiveFile",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Compile “${TM_FILENAME}”\" \"Context Free\"\n\nSIZE=400\nRES=\"/tmp/tm_cfdg_${TM_FILENAME%.*}.png\"\n\ncfdg -s $SIZE \"$TM_FILEPATH\" \"$RES\"|pre\n\nif [[ -e \"$RES\" ]]; then\n  echo \"<img src='tm-file://${RES// /%20}' width='$SIZE' height='$SIZE'>\"\n  { sleep 20; rm -f \"$RES\"; } &>/dev/null &\nfi\n\nhtml_footer\n",
  input: "none",
  keyEquivalent: "@r",
  name: "Render",
  output: "showAsHTML",
  scope: "source.context-free",
  uuid: "919889A9-590B-45CD-AEA2-CFC3452B16C7"},
 {beforeRunningCommand: "nop",
  command: 
   "content () {\n\tperl -pe 's/[\"\\\\]/\\\\$&/g'\n}\n\nosascript <<-APPLESCRIPT\n\ttell application \"Context Free\" to activate\n\tmenu_click({\"Context Free\", \"File\", \"New\"})\n\ttell app \"System Events\"\n\t\tset value of ((process \"Context Free\")'s (window 1)'s (splitter group 1)'s (group 1)'s (scroll area 1)'s (text area 1)) to \"$(content)\"\n\tend tell\n\tmenu_click({\"Context Free\", \"Render\", \"Render\"})\n\n\n\t-- Helper functions\n\ton menu_click(mList)\n\t\tlocal appName, topMenu, r\n\t\tif mList's length < 3 then error \"Menu list is not long enough\"\n\t\tset {appName, topMenu} to (items 1 through 2 of mList)\n\t\tset r to (items 3 through (mList's length) of mList)\n\t\ttell app \"System Events\" to my menu_click_recurse(r, ((process appName)'s (menu bar 1)'s (menu bar item topMenu)'s (menu topMenu)))\n\tend menu_click\n\ton menu_click_recurse(mList, parentObject)\n\t\tlocal f, r\n\t\tset f to item 1 of mList\n\t\tif mList's length > 1 then set r to (items 2 through (mList's length) of mList)\n\t\ttell app \"System Events\"\n\t\t\tif mList's length is 1 then\n\t\t\t\tclick parentObject's menu item f\n\t\t\telse\n\t\t\t\tmy menu_click_recurse(r, (parentObject's (menu item f)'s (menu f)))\n\t\t\tend if\n\t\tend tell\n\tend menu_click_recurse\n\nAPPLESCRIPT",
  input: "selection",
  name: "Render in Context Free",
  output: "showAsTooltip",
  scope: "source.context-free",
  uuid: "4A4BCD2A-C90D-4F5B-90A5-3C1B4208FBD6"}]
