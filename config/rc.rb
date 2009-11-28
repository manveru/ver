VER.options.dsl do
  o "Default Font for all widgets",
    :font, "TkFixedFont 10"

  o "Internal:External encoding",
    :encoding, "UTF-8:UTF-8"

  o "Tk Tile Theme",
    :tk_theme, 'clam'

  o "Syntax highlighting theme",
    :theme, "Blackboard"

  o "Keymap used",
    :keymap, 'vim'

  o "Expand all tabs into spaces",
    :expandtab, true

  o "Use automatic indentation",
    :autoindent, true

  o "Number of spaces used in autoindent",
    :shiftwidth, 2

  o "Number of spaces a tab stands for",
    :tabstop, 8

  o "Number of characters after which wrap commands will wrap",
    :textwidth, 80

  o "In case of a total failure, this key binding should bail you out",
    :emergency_exit, "<Control-q>"

  o "Fork off on startup to avoid dying with the terminal",
    :fork, true

  o "Milliseconds that the cursor is visible when blinking",
    :insertontime, 500

  o "Milliseconds that the cursor is invisible when blinking",
    :insertofftime, 0

  o "Width of one tab in pixel",
    :tabs, 10

  o "Default filetype if no matching syntax can be found",
    :filetype, "Plain Text"
end
