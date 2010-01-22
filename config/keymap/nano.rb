module VER
  major_mode :fundamental do
    minor_modes :text
  end

  major_mode :entry do
    minor_modes :readline
  end

  minor_mode :readline do
    add 'prev_char', '<Left>', '<Control-b>'
    add 'prev_word', '<Shift-Left>', '<Alt-b>'
    add 'next_char', '<Right>', '<Control-f>'
    add 'next_word', '<Shift-Right>', '<Alt-f>'
  end

  minor_mode :select do
    based_on :text
  end

  minor_mode :text do
    add 'Help.help', '^g', '<F1>' # Display this help text
    add 'Views.close', '^x', '<F2>' # Close the current file buffer / Exit from nano
    add 'Save.save', '^o', '<F3>' # Write the current file to disk
    add 'Control.wrap', '^j', '<F4>' # Justify the current paragraph

    add 'Insert.file', '^r', '<F5>' # Insert another file into the current one
    add 'Search.ask_next', '^w', '<F6>' # Search for a string or a regular expression
    add 'Views.focus_prev', '^y', '<F7>' # Go to previous screen
    add 'Views.focus_next', '^v', '<F8>' # Go to next screen

    add 'Delete.kill_line', '^k', '<F9>' # Cut the current line and store it in the cutbuffer
    add 'Clipboard.paste', '^u', '<F10>' # Uncut from the cutbuffer into the current line
    # add '^c',     '<F11>' # Display the position of the cursor
    # add '^t',     '<F12>' # Invoke the spell checker, if available

    add 'Move.go_line', 'M-\\', 'M-|' # Go to the first line of the file
    add 'Move.end_of_file', 'M-/', 'M-?' # Go to the last line of the file

    add 'Move.go_line_col', '^_', '<F13>', 'M-g' # Go to line and column number
    add 'Search.replace', '^\\', '<F14>', 'M-r' # Replace a string or a regular expression
    become :select, '^^', '<F15>', 'M-a' # Mark text at the cursor position
    add 'Search.next', 'M-w', '<F16>' # Repeat last search

    add 'Clipboard.copy_line', 'M-^', 'M-6' # Copy the current line and store it in the cutbuffer
    add 'Control.indent_line', 'M-}' # Indent the current line
    add 'Control.unindent_line', 'M-{' # Unindent the current line
    add 'Move.next_char', '^f', '<Right>' # Go forward one character
    add 'Move.prev_char', '^b', '<Left>' # Go back one character
    add 'Move.next_word', '<Control-space>' # Go forward one word
    add 'Move.prev_word', '<Alt-space>' # Go back one word
    add 'Move.prev_line', '^p', '<Up>' # Go to previous line
    add 'Move.next_line', '^n', '<Down>' # Go to next line

    add 'Move.start_of_line', '^a' # Go to beginning of current line
    add 'Move.end_of_line', '^e' # Go to end of current line
    # add 'M-(',    'M-9' # Go to beginning of paragraph; then of previous paragraph
    # add 'M-)',    'M-0' # Go just beyond end of paragraph; then of next paragraph
    add 'Move.matching_brace', 'M-]' # Go to the matching bracket
    add 'Move.backward_scroll', 'M--', 'M-_' # Scroll up one line without scrolling the cursor
    add 'Move.forward_scroll', 'M-+', 'M-=' # Scroll down one line without scrolling the cursor
    add 'Views.cycle_prev', 'M-<', 'M-,' # Switch to the previous file buffer
    add 'Views.cycle_next', 'M->', 'M-.' # Switch to the next file buffer

    add 'Insert.verbatim', 'M-v' # Insert the next keystroke verbatim
    add 'Insert.tab', '^i' # Insert a tab at the cursor position
    add 'Insert.newline', '^m' # Insert a newline at the cursor position
    add 'Delete.next_char', '^d' # Delete the character under the cursor
    add 'Delete.prev_char', '^h' # Delete the character to the left of the cursor
    add 'Delete.to_eof', 'M-t' # Cut from the cursor position to the end of the file

    # add 'M-j'                    Justify the entire file
    # add 'M-d'                    Count the number of words, lines, and characters
    # add '^l'                     Refresh (redraw) the current screen
    # add '^z'                     Suspend the editor (if suspend is enabled)
  end
end
