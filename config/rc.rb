VER.options.dsl do
  o "Use automatic indentation",
    :autoindent, true

  o "Sequence to comment a line, may change through file type preferences",
    :comment_line, '#'

  o "Start and end sequence to comment a region, may change through file type preferences",
    :comment_region, ['=begin', '=end']

  o "Internal:External encoding",
    :encoding, "UTF-8:UTF-8"

  o "Expand all tabs into spaces",
    :expandtab, true

  o "In case of a total failure, this key binding should bail you out",
    :emergency_exit, "<Control-q>"

  o "Default Font for all widgets",
    :font, "TkFixedFont 10"

  o "Fork off on startup to avoid dying with the terminal",
    :fork, true

  o "Use EventMachine inside VER, at the moment only for the console",
    :eventmachine, false

  o "Change directory to directory of currently open buffer",
    :auto_chdir, false

  o "Tk Tile Theme",
    :tk_theme, 'clam'

  o "Syntax highlighting theme",
    :theme, "Blackboard"

  o "Keymap used",
    :keymap, 'vim'

  o "Number of spaces used in autoindent",
    :shiftwidth, 2

  o "Number of spaces a tab stands for",
    :tabstop, 8

  o "Number of characters after which wrap commands will wrap",
    :textwidth, 80

  o "Minimum size of search term to start incremental highlighting",
    :search_incremental_min, 1

  o "Show vertical scrollbar",
    :vertical_scrollbar, false

  o "Show horizontal scrollbar",
    :horizontal_scrollbar, false

  o "Milliseconds that the cursor is visible when blinking",
    :insertontime, 500

  o "Milliseconds that the cursor is invisible when blinking",
    :insertofftime, 0

  o "Format for Statusline",
    :statusline, '%r\t%4l,%c %P\t[%m%_s%_e]'

  o "Default filetype if no matching syntax can be found",
    :filetype, "Plain Text"

  o "Interval at which pending syntax highlights are done",
    :syntax_highlight_interval, 500

  o "Width at which lines are cut when autofill is active",
    :auto_fill_width, 78
end
