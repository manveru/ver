# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"Transmit Bundle Help\" \"Transmit\"\n\"$TM_SUPPORT_PATH/lib/markdown_to_help.rb\" <<'MARKDOWN'\n\n# Synopsis\n\nThe Transmit bundle offers you a way to have the current document or its containing folder uploaded via the [Transmit][] file transfer program.\n\n[Transmit]: http://www.panic.com/transmit/\n\n# DockSend Setup\n\nThe two commands with a “(DockSend)” suffix assumes that you have configured Transmit to have DockSend enabled for the containing folder of the current document.\n\nThis is done by starting Transmit, connect to your server as usual and then from the Favorites menu select Add to Favorites…\n\nIn the sheet which appears, you need to click the downward pointing arrow with a “More Options” label.\n\nThis expands the sheet so it looks like in the following picture:\n\n![Add to Favorites](add_to_favorites.png)\n\nThere are 3 settings of importance here:\n\n 1. **Remote Path** — This is where, on the server, you want your files uploaded.\n\n 2. **Local Path** — This is where the files are located on your own machine.\n\n 3. **Use DockSend** — Check this box to enable the feature.\n\nIn the picture we have set the remote path to `/usr/home/raven/public_html` and the local path to `~/scavenger`.\n\nWhat this means is that if we edit `~/scavenger/index.html` and select Trasmit → Send Document (DockSend) then it will be uploaded to the server as `/usr/home/raven/public_html/index.html`\n\nMARKDOWN\nhtml_footer\n",
  dontFollowNewOutput: true,
  input: "none",
  name: "Help",
  output: "showAsHTML",
  uuid: "BF39FA53-3EFD-4CA8-9789-BA606C7883B9"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#!/bin/sh\nosascript \"${TM_BUNDLE_SUPPORT}/send_to_transmit.applescript\" \"$TM_FILEPATH\" &>/dev/console &\necho \"Sent ‘${TM_FILENAME}’ to Transmit\"\n",
  input: "none",
  keyEquivalent: "^F",
  name: "Send Document (DockSend)",
  output: "showAsTooltip",
  uuid: "91FC4F89-ADA9-4435-B159-9BA348FDE590"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "osascript <<-\"APPLESCRIPT\" - \"$TM_FILEPATH\"\non run(argv)\n\ttell application \"Transmit\"\n\t\t(upload item (item 1 of argv)) in current session of first document\n\tend tell\nend run\nAPPLESCRIPT\n",
  input: "none",
  keyEquivalent: "^F",
  name: "Send Document With Active Connection",
  output: "showAsTooltip",
  uuid: "C958B58A-D4D4-4055-89DF-22BCA3B8A9CA"},
 {beforeRunningCommand: "saveModifiedFiles",
  command: 
   "#!/bin/sh\nosascript \"${TM_BUNDLE_SUPPORT}/send_to_transmit.applescript\" \"$TM_DIRECTORY\" &>/dev/console &\necho \"Sent folder ‘`basename ${TM_DIRECTORY}`’ to Transmit\"\n",
  input: "none",
  keyEquivalent: "^F",
  name: "Send Folder (DockSend)",
  output: "showAsTooltip",
  uuid: "C4006FCA-85FF-4476-BDA8-34EF355FD0E4"}]
