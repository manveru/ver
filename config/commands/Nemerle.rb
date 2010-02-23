# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Compile &amp; Run\" \"Nemerle\"\nrequire_cmd ncc\n\nncc \"$TM_FILEPATH\" -o \"$TM_FILEPATH\".exe && mono \"$TM_FILEPATH\".exe\n\nhtml_footer",
  input: "document",
  keyEquivalent: "@r",
  name: "Compile & Run",
  output: "showAsHTML",
  scope: "source.nemerle",
  uuid: "AF355E00-4F11-11DB-B7AC-00112474B8F0"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Compile Library\" \"Nemerle\"\nrequire_cmd ncc\n\nncc -t:library \"$TM_FILEPATH\" -o \"$TM_FILEPATH\".dll",
  input: "document",
  keyEquivalent: "@R",
  name: "Compile Library",
  output: "showAsHTML",
  scope: "source.nemerle",
  uuid: "04046396-4FB2-11DB-ADD3-00112474B8F0"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Compile Macro\" \"Nemerle\"\nrequire_cmd ncc\n\nncc -r:Nemerle.Compiler -t:library \"$TM_FILEPATH\" -o \"$TM_FILEPATH\".dll",
  input: "document",
  keyEquivalent: "@R",
  name: "Compile Macro",
  output: "showAsHTML",
  scope: "source.nemerle",
  uuid: "BBD358C1-4FB6-11DB-ADD3-00112474B8F0"}]
