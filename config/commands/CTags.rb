# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "# just to remind you of some useful environment variables\n# see Help / Environment Variables for the full list\n#echo File: \"$TM_FILEPATH\"\n#echo Word: \"$TM_CURRENT_WORD\"\n#echo Selection: \"$TM_SELECTED_TEXT\"\n\nexec \"$TM_BUNDLE_SUPPORT/bin/tmctags\"\n",
  input: "none",
  keyEquivalent: "^]",
  name: "Find Tags",
  output: "showAsHTML",
  scope: "source",
  uuid: "4E4A0404-8560-483A-B975-E53F6A6B7E25"},
 {beforeRunningCommand: "nop",
  bundleUUID: "0D39D7BD-CD02-48EF-BB9C-2210BFFC5AD7",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"CTags Help\" \"CTags\"\nMarkdown.pl <<'EOF'|SmartyPants.pl\n\nCTags.tmbundle\n---------------\n\nThe CTags bundle allows you to quickly look up function definitions, variables etc. It uses the [Exuberant CTags][1] program freely available under the terms of the [GNU General Public License][2] to generate a list of definitions, and presents any match for the current word when invoked.\n\nUsage\n-----\n\nWith the cursor over a word for which you want to see the definition, select *CTags/Find Tags* or press the assigned shortcut. A window will show up listing all locations where the term was defined, as well as your current location so you can easily find your way back. If only one location is found, TextMate will jump there (this behavior can be changed with the  *TmCtagsAutoJump* environment variable, see below).\n\nIf you modify the source code, the definition list will become out of sync with your code. Invoke *CTags/Update Tags* to update it.\n\n**Note:** The definitions are stored in a file named *tmtags* in your project root directory. It is safe to delete this file when no longer needed. The bundle will recreate it on the fly whenever needed.\n\nTo exclude certain files or directories (eg source control files), add the appropiate options to the `.ctags` file in your home directory. An example:\n\n\t--exclude=*~\n\t--exclude=\\._*\n\t--exclude=*\\.bak\n\t--exclude=\\.svn\n\t--exclude=_darcs\n\nPlease see the ctags man page or the [Exuberant CTags][1] documentation for more info.\n\n\nConfiguration\n-------------\n\nThe CTags bundle can be configured by adding environment variables, either to a project to only change the behavior within a project, or globally (TextMate/Preferences/Advanced/Shell Variables). The following variables are honored:\n\n* TmCtagsAutoJump\n\nSet this variable to 0 to avoid TextMate jumping when a unique definition is found. Default value: *1*.\n\n* TmCtagsTagFileName\n\nThe file name used to store tags in. Default is *tmtags*.\n\n* TM\\_TAGS\\_FILE\n\nFor backward-compatibility with the *Lookup Definition (ctags)* command from the Source bundle. Only makes sense inside a project. If set must contain the full path and filename for the tags file ctags will use. The path also is the root from which ctags does its work (although additional directories can be added).\n\n* TmCtagsFlags\n\nAny additional flags or options the ctags program should honor.\n\n* TmCtagsTimeout\n\nThe timeout in seconds after which ctags is considered hanging (there are some bugs in ctags) and it is killed. Default is 30 seconds. For really large projects that may need to be increased.\n\n* TmCtagsSoundDir\n\nDirectory in which sound files are expected. Default is *'/System/Library/Sounds'*.\n\n* TmCtagsOkSingleSound\n\nThe name for the sound file played when a unique definition is found. If the extension is *.aiff* it can be omitted. Set to empty string for no sound. Default is an empty string.\n\n* TmCtagsOkMultiSound\n\nThe name for the sound file played when multiple definitions are found. If the extension is *.aiff* it can be omitted. Set to empty string for no sound. Default is *Frog*.\n\n* TmCtagsErrorSound\n\nThe name for the sound file played when no definitions are found. If the extension is *.aiff* it can be omitted. Set to empty string for no sound. Default is *Sosumi*.\n\n* TM\\_CTAGS\\_ADDITIONAL\\_DIRECTORIES\n\nAdditional directories for CTags to process for tags. Directories should be seperated by the colon character (\":\").\n\nCredits\n-------\n\nThis bundle is maintained by [Gerd Knops][3].\n\nFeedback is welcome: gerti-ctagstmb@bitart.com\n\n[1]: http://ctags.sourceforge.net/\n[2]: http://www.gnu.org/copyleft/gpl.html\n[3]: http://gerd.knops.com/\n\nEOF\nhtml_footer",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  scope: "source",
  uuid: "CF06E855-A45F-4AC0-A5F3-D9A99B2D7059"},
 {beforeRunningCommand: "nop",
  command: 
   "# just to remind you of some useful environment variables\n# see Help / Environment Variables for the full list\n#echo File: \"$TM_FILEPATH\"\n#echo Word: \"$TM_CURRENT_WORD\"\n#echo Selection: \"$TM_SELECTED_TEXT\"\n\nexec \"$TM_BUNDLE_SUPPORT/bin/tmctags\" update\n",
  input: "none",
  keyEquivalent: "^~]",
  name: "Update Tags",
  output: "showAsTooltip",
  scope: "source",
  uuid: "F82D2DF8-6914-4EEC-BA46-F1E4B1716108"}]
