# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Scilab Bundle Help\" \"Scilab\"\n\n\"$TM_SUPPORT_PATH/lib/markdown_to_help.rb\" <<'EOF'\n\n# Help for Scilab Bundle (v0.11)\n\nThis Scilab bundle was created to help make editing Scilab scripts in TextMate a little easier. The two main benefits are:\n\n1. **Syntax Highlighting**\n\n  Most conventional Scilab scripts should be interpreted correctly using the language grammar provided with this bundle. You'll get all the benefits of syntax highlighting, function pop-ups, and code folding.\n\n2. **Run Script Command**\n\n  If you have `Scilab-4.1.app` installed, you'll be able to run the current script in a new instance of Scilab by simply pressing &#x2318;R. You can also load all functions defined in the working directory first (using getd) by pressing &#x21E7;&#x2318;R.\n\n  You can obtain `Scilab-4.1.app` at <a href=\"javascript:TextMate.system('open http://www.lmac.utc.fr/~mottelet/Darwin/', null);\">http://www.lmac.utc.fr/~mottelet/Darwin/</a>.\n\nIf you have any suggestions or bug reports, feel free to send them to <a href=\"mailto:jc483@cornell.edu?subject=Scilab Bundle\">jc483@cornell.edu</a> with the subject \"Scilab Bundle\".\n\n# Version History\n\n- v0.11 (March 5th, 2007)\n\t- Thanks to Allan Odgaard for reviewing this bundle\n\t\t- Help now uses `markdown_to_help.rb` instead of `Markdown.pl`\n\t\t- `Scilab-4.1.app` is now located using `find_app`\n- v0.1 (March 3rd, 2007)\n\t- Initial release\n\n# About This Bundle\n\n## Disclaimer\n\nI'm just an amateur programmer, so it's very likely that there are better ways to automate some of the things that this bundle attempts to do. Feel free to correct any errors you may find, and if you want, you can publish your changes for everyone's benefit.\n\n## Credits\n\nCreated by Jiun Wei Chia. Various code stolen from the default TextMate bundles.\n\nEOF\n\nhtml_footer",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  scope: "source.scilab",
  uuid: "B2908B89-B064-447E-B3A7-C03D4BEE6D1C"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "export APP=`find_app Scilab-4.1.app`\nLAUNCHER=$APP/Contents/Resources/launcher.sh\nif [ -x \"$LAUNCHER\" ]\nthen\n\tDIRECTORY=`echo \"$TM_DIRECTORY\" | sed -e \"s/'/''/g\" -e \"s/\\\"/\\\"\\\"/g\"`\n\tFILEPATH=`echo \"$TM_FILEPATH\" | sed -e \"s/'/''/g\" -e \"s/\\\"/\\\"\\\"/g\"`\n\techo \"cd('$DIRECTORY'); exec('$FILEPATH');\" > /tmp/scilab.sce\n\t$LAUNCHER -f /tmp/scilab.sce\nelse\n\techo \"Scilab 4.1 not found.\"\n\techo \"Please copy Scilab-4.1.app to the Applications directory.\"\nfi\n",
  input: "none",
  keyEquivalent: "@r",
  name: "Run Script",
  output: "showAsTooltip",
  scope: "source.scilab",
  uuid: "14038705-CA2C-4386-8B21-3EEF52A15537"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "export APP=`find_app Scilab-4.1.app`\nLAUNCHER=$APP/Contents/Resources/launcher.sh\nif [ -x \"$LAUNCHER\" ]\nthen\n\tDIRECTORY=`echo \"$TM_DIRECTORY\" | sed -e \"s/'/''/g\" -e \"s/\\\"/\\\"\\\"/g\"`\n\tFILEPATH=`echo \"$TM_FILEPATH\" | sed -e \"s/'/''/g\" -e \"s/\\\"/\\\"\\\"/g\"`\n\techo \"cd('$DIRECTORY'); getd('$DIRECTORY'); exec('$FILEPATH');\" > /tmp/scilab.sce\n\t$LAUNCHER -f /tmp/scilab.sce\nelse\n\techo \"Scilab 4.1 not found.\"\n\techo \"Please copy Scilab-4.1.app to the Applications directory.\"\nfi\n",
  input: "none",
  keyEquivalent: "@R",
  name: "Run Script (with getd)",
  output: "showAsTooltip",
  scope: "source.scilab",
  uuid: "FCD467AA-0FAF-4B63-A613-E7175B80709A"}]
