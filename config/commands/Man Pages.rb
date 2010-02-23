# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "res=$(ruby -rui -e\"print TextMate::UI.request_string(:title => 'Manual Page', :prompt => 'What manual page do you want?', :button1 => 'View', :button2 => 'Cancel').to_s\")\n\n[[ -z \"$res\" ]] && exit_discard\n\n$(\"$TM_BUNDLE_SUPPORT/mman\"<<<\"$res\")\n",
  input: "none",
  keyEquivalent: "",
  name: "View Man Page",
  output: "showAsTooltip",
  uuid: "71AB34F4-755D-4F16-A45F-93CD88246ED7"},
 {beforeRunningCommand: "nop",
  command: 
   "# Place a symlink to \"$TM_BUNDLE_SUPPORT/mman\" somewhere in your path\n# and then you can bring up man pages in TextMate via the terminal\n# using \"mman <manpage>\"\n\n\"$TM_BUNDLE_SUPPORT/mman\"",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "",
  name: "Visit Man Page",
  output: "showAsTooltip",
  scope: "markup.underline.link.internal.man",
  uuid: "876E1F2C-8FD2-4E93-803D-55F182BDA009"}]
