module VER
  module Ncurses
    class Window < Struct.new(:pointer)
      def initialize(height = 0, width = 0, top = 0, left = 0)
        self.pointer = Ncurses.newwin(height, width, top, left)
      end

      # Current cursor position [y, x]
      def getyx
        Ncurses.getyx(pointer)
      end

      # Current vertical cursor position y.
      def getcury
        Ncurses.getcury(pointer)
      end

      # Current horizontal cursor position x.
      def getcurx
        Ncurses.getcurx(pointer)
      end

      # If this is a subwindow, this method returns the beginning coordinates
      # of the window relative to the parent window as [y, x].
      def getparyx
        Ncurses.getparyx(pointer)
      end

      # Return the beginning coordinates of the window as [y, x].
      def getbegyx
        Ncurses.getbegyx(pointer)
      end

      # Return the bottom-right coordinates of the window as [y, x].
      def getmaxyx
        Ncurses.getmaxyx(pointer)
      end

      # Move the cursor associated with the window to line y and column x.
      # Doesn't move the physical cursor of the terminal until refresh is
      # called.
      # The position specified is relative to the upper left-had corner of the
      # window, which is (0,0).
      #
      # @param [Fixnum] y
      # @param [Fixnum] x
      def move(y, x)
        Ncurses.wmove(pointer, y, x)
      end

      # If idcok is called with false as argument, curses no longer considers
      # using the hardware insert/delete character feature of terminals so
      # equipped.
      #
      # Use of character insert/delete is enabled by default.
      # Calling idcok with true re-enables use of character insertion and
      # deletion.
      #
      # @param [true, false, nil] bool

      def idcok(bool = true)
        Ncurses.idcok(pointer, bool ? 1 : 0)
      end
      alias idcok= idcok

      # If immedok is called with true as argument, any change in the window
      # image, such as the ones caused by {waddch}, {wclrtobot}, {wscrl}, etc.,
      # automatically cause a call to {wrefresh}.
      # However, it may degrade performance considerably, due to repeated calls
      # to {wrefresh}.
      #
      # It is disabled by default.
      #
      # @param [true, false, nil] bool

      def immedok(bool = false)
        Ncurses.immedok(pointer, bool ? 1 : 0)
      end
      alias immedok= immedok

      # Manipulate the background of the window.
      #
      # The window background consists of any combination of attributes (i.e.,
      # rendition) and a character.
      #
      # The attribute part of the background is combined (OR'ed) with all
      # non-blank characters that are written into the window with {waddch}.
      # Both the character and attribute parts of the background are combined
      # with the blank characters.
      # The background becomes a property of the character and moves with the
      # character through any scrolling and insert/delete line/character
      # operations.
      #
      # To the extent possible on a particular terminal, the attribute part of
      # the background is displayed as the graphic rendition of the character
      # put on the screen.
      #
      # The {bkgd} and {wbkgd} methods set the background property of the
      # current or specified window and then apply this setting to every
      # character position in that window:
      #
      #  The rendition of every character on the screen is changed to the new
      #  background rendition.
      #
      #  Wherever the former background character appears, it is changed to the
      #  new background character.
      #
      # The {getbkgd} method returns the given window's current background
      # character/attribute pair.

      def wbkgdset(color)
        Ncurses.wbkgdset(pointer, color)
      end

      # Manipulate the background of the window.
      #
      # The window background is consists of any combination of attributes
      # (i.e., rendition) and a complex character.
      #
      # The attribute part of the background is combined (OR'ed) with all
      # non-blank characters that are written into the window with {waddch}.
      # Both the character and attribute parts of the background are combined
      # with the blank characters.
      # The background becomes a property of the character and moves with the
      # character through any scrolling and insert/delete line/character
      # operations.
      #
      # To the extent possible on a particular terminal, the attribute part of
      # the background is displayed as the graphic rendition of the character
      # put on the screen.
      #
      # The {bkgrd} and {wbkgrd} methods set the background property of the
      # current or specified window and then apply this setting to every
      # character position in that window:
      #
      #  The rendition of every character on the screen is changed to the new
      #  background rendition.
      #
      #  Wherever the former background character appears, it is changed to the
      #  new background character.
      #
      # The {getbkgrnd} methods returns the given window's current background
      # character/attribute pair.

      def wbkgrndset(color)
        Ncurses.wbkgrndset(pointer, color)
      end


      # Updates the current cursor position of all the ancestors of the window
      # to reflect the current cursor position of the window.
      def wcursyncup
        Ncurses.wcursyncup(pointer)
      end
      alias cursyncup wcursyncup

      # Touches each location in win that has been touched in any of its
      # ancestor windows.
      # This is called by {wrefresh}, so it should almost never be necessary to
      # call it manually.
      def wsyncdown
        Ncurses.wsyncdown(pointer)
      end
      alias syncdown wsyncdown

      # Touches all locations in ancestors of the window that are changed in
      # the window.
      # It is called automatically whenever there is a change in the window if
      # syncok is enabled.
      def wsyncup
        Ncurses.wsyncup(pointer)
      end
      alias syncup wsyncup

      # Set blocking or non-blocking read for a given window.
      # If +delay+ is negative, blocking read is used (i.e., waits indefinitely
      # for input).
      # If +delay+ is zero, then non-blocking read is used (i.e., read returns
      # ERR if no input is waiting).
      # If +delay+ is positive, then read blocks for +delay+ milliseconds, and
      # returns ERR if there is still no input.
      #
      # This provides the same functionality as {nodelay}, plus the additional
      # capability of being able to block for only +delay+ milliseconds (where
      # +delay+ is positive).
      #
      # @param [Fixnum] delay in milliseconds

      def wtimeout(delay)
        Ncurses.wtimeout(pointer, delay.to_i)
      end
      alias timeout= wtimeout

      # Calling derwin is the same as calling subwin, except that +begin_y+ and
      # +begin_x+ are relative to the origin of the window orig rather than the
      # screen.
      #
      # There is no difference between the subwindows and the derived windows.
      def derwin(lines, cols, begin_y, begin_x)
        Ncurses.derwin(pointer, lines, cols, begin_y, begin_x)
      end

      # Calling dupwin creates an exact duplicate of the window win.
      def dupwin
        instance = clone
        instance.win = Ncurses.dupwin(pointer)
        instance
      end
      alias dup dupwin

      # The getwin routine reads window related data stored in the file by
      # putwin.
      # The routine then creates and initializes a new window using that data.
      # It returns a pointer to the new window.
      #
      # FIXME
      def getwin(file)
        Ncurses.getwin(file)
      end

      # The putwin routine writes all data associated with window win into the file
      # to which filep points. This information  can  be later retrieved using the
      # getwin function.
      #
      # FIXME
      def putwin(file)
        Ncurses.putwin(file)
      end

      # Creates and returns a pointer to a subwindow within a pad.
      #
      # Unlike subwin, which uses screen coordinates, the window is at position
      # (+begin_x+, +begin_y+) on the pad.
      #
      # The window is made in the middle of the window orig, so that changes
      # made to one window affect both windows.
      # During the use of this routine, it will often be necessary to call
      # touchwin or touchline on orig before calling prefresh.
      def subpad(lines, cols, begin_y, begin_x)
        Ncurses.subpad(pointer, lines, cols, begin_y, begin_x)
      end

      def subwin(lines, cols, begin_y, begin_x)
        Ncurses.subwin(pointer, lines, cols, begin_y, begin_x)
      end

      # Returns true if the specified line was modified since the last call to {wrefresh}.
      # Otherwise returns false, or ERR if line is not valid for the window.
      def is_linetouched(line)
        Ncurses.is_linetouched(pointer, line)
      end
      alias line_touched? is_linetouched

      # Returns true if the window was modified since the last call to {wrefresh}.
      # Otherwise returns false.
      def is_wintouched
        Ncurses.is_wintouched(pointer)
      end
      alias touched? is_wintouched

      def winch
        Ncurses.winch(pointer)
      end

      # If clearok is called with true as argument, the next call to wrefresh
      # with this window will clear the screen completely and redraw the entire
      # screen from scratch.
      #
      # This is useful when the contents of the screen are uncertain, or in
      # some cases for a more pleasing visual effect.
      def clearok(bool = true)
        Ncurses.clearok(bool ? 1 : 0)
      end
      alias clearok= clearok


      # Calling delwin deletes window, freeing all memory associated with it.
      # It does not actually erase the window's screen image.
      # Subwindows must be deleted before the main window can be deleted.
      def delwin
        Ncurses.delwin(pointer)
        pointer = nil
      end

      # If idlok is called with true argument, curses considers using the
      # hardware insert/delete line feature of terminals so equipped.
      #
      # Calling idlok with false as argument disables use of line insertion and
      # deletion.
      #
      # This option should be enabled only if the application needs
      # insert/delete line, for example, for a screen editor.
      # It is disabled by default because insert/delete line tends to be
      # visually annoying when used in applications where it is not really
      # needed.
      # If insert/delete line cannot be used, curses redraws the changed
      # portions of all lines.
      def idlok(bool = false)
        Ncurses.idlok(pointer, bool ? 1 : 0)
      end
      alias idlok= idlok

      # If the intrflush option is enabled, when an interrupt key is pressed on the
      # keyboard (interrupt, break, quit) all output in the tty driver queue
      # will be flushed, giving the effect of faster response to the interrupt,
      # but causing curses to have the wrong idea of what is on the screen.
      # Disabling the option prevents the flush.
      #
      # The default for the option is inherited from the tty driver settings.
      # Although a method on Window, it affects everything else.
      def intrflush(bool = false)
        Ncurses.intrflush(pointer, bool ? 1 : 0)
      end
      alias intrflush= intrflush

      # The keypad option enables the keypad of the user's terminal.
      #
      # If enabled, the user can press a function key (such as  an arrow key)
      # and wgetch returns a single value representing the function key, as in
      # KEY_LEFT.
      # If disabled, curses does not treat function keys specially and the
      # program has to interpret the escape sequences itself.
      #
      # If the keypad in the terminal can be turned on (made to transmit) and
      # off (made to work locally), turning on this option causes the terminal
      # keypad to be turned on when {wgetch} is called.
      #
      # The default value for keypad is false.
      def keypad(bool = false)
        Ncurses.keypad(pointer, bool ? 1 : 0)
      end
      alias keypad= keypad

      # Normally, the hardware cursor is left at the location of the window
      # cursor being refreshed.
      #
      # The leaveok option allows the cursor to be left wherever the update
      # happens to leave it.
      #
      # It is useful for applications where the cursor is not used, since it
      # reduces the need for cursor motions.
      def leaveok(bool = false)
        Ncurses.leaveok(pointer, bool ? 1 : 0)
      end
      alias leaveok= leaveok

      # Initially, whether the terminal returns 7 or 8 significant bits on
      # input depends on the control mode of the tty driver [see termio(7)].
      #
      # To force 8 bits to be returned, invoke meta(true); this is equivalent,
      # under POSIX, to setting the CS8 flag on the terminal.
      # To force 7 bits to be returned, invoke meta(false); this is equivalent,
      # under POSIX, to setting the CS7 flag on the terminal.
      # The window argument, win, is always ignored.
      # If the terminfo capabilities smm (meta_on) and rmm (meta_off) are
      # defined for the terminal, smm is sent to the terminal when meta(true)
      # is called and rmm is sent when meta(false) is called.
      def meta(bool = true)
        Ncurses.meta(pointer, bool ? 1 : 0)
      end
      alias meta= meta

      # The nodelay option causes getch to be a non-blocking call.
      # If no input is ready, getch returns ERR.
      # If disabled, getch waits until a key is pressed.
      def nodelay(bool = true)
        Ncurses.nodelay(pointer, bool ? 1 : 0)
      end
      alias nodelay= nodelay

      # While interpreting an input escape sequence, {wgetch} sets a timer
      # while waiting for the next character.
      # If notimeout(true) is called, then wgetch does not set a timer.
      # The purpose of the timeout is to differentiate between sequences
      # received from a function key and those typed by a user.
      def notimeout(bool = true)
        Ncurses.notimeout(pointer, bool ? 1 : 0)
      end
      alias notimeout= notimeout

      # The scrollok option controls what happens when the cursor of a window
      # is moved off the edge of the window or scrolling region, either as a
      # result of a newline action on the bottom line, or typing the last
      # character of the last line.
      #
      # If disabled, the cursor is left on the bottom line.
      #
      # If enabled, the window is scrolled up one line (Note that to get the
      # physical scrolling effect on the terminal, it is also necessary to call
      # {idlok}).
      def scrollok(bool = true)
        Ncurses.scrollok(pointer, bool ? 1 : 0)
      end
      alias scrollok= scrollok

      # Calling {wsyncup} touches all locations in ancestors of win that are
      # changed in win.
      # If syncok is called with true then {wsyncup} is called automatically
      # whenever there is a change in the window.
      def syncok(bool = true)
        Ncurses.syncok(pointer, bool ? 1 : 0)
      end
      alias syncok= syncok

      # Calling mvderwin moves a derived window (or subwindow) inside its
      # parent window.
      # The screen-relative parameters of the window are not changed.
      # This routine is used to display different parts of the parent window at
      # the same physical position on the screen.
      def mvderwin(y, x)
        Ncurses.mvderwin(pointer, y, x)
      end

      # Calling mvwin moves the window so that the upper left-hand corner is at
      # position (+x+, +y+).
      # If the move would cause the window to be off the screen, it is an error
      # and the window is not moved.
      # Moving subwindows is allowed, but should be avoided.
      def mvwin(y, x)
        Ncurses.mvwin(pointer, y, x)
      end

      # The scanw, wscanw and mvscanw routines are analogous to scanf [see scanf(3)].
      # The effect of these routines is as though wgetstr were called on the
      # window, and the resulting line used as input for sscanf(3).
      # Fields which do not map to a variable in the fmt field are lost.
      def mvwscanw(y, x, format)
        Ncurses.mvwscanw(pointer, y, x, format)
      end

      # Overlay window on top of +dest_win+.
      #
      # The copying is non-destructive (blanks are not copied).
      #
      # The windows are not required to be the same size; only text where the
      # two windows overlap is copied.
      def overlay(dest_win)
        if dest_win.respond_to?(:win)
          Ncurses.overlay(pointer, dest_win.win)
        else
          Ncurses.overlay(pointer, dest_win)
        end
      end

      # Overwrite window on top of +dest_win+.
      #
      # The copying is destructive (blanks are copied as well).
      #
      # The windows are not required to be the same size; only text where the
      # two windows overlap is copied.
      def overwrite(dest_win)
        if dest_win.respond_to?(:win)
          Ncurses.overwrite(pointer, dest_win.win)
        else
          Ncurses.overwrite(pointer, dest_win)
        end
      end

      # Analogous wide-character form of {pechochar}.
      # It outputs one character to a pad and immediately refreshes the pad.
      # It does this by a call to {wadd_wch} followed by a call to {prefresh}.
      def pecho_wchar(char)
        Ncurses.pecho_wchar(pointer, char)
      end

      # The pechochar routine is functionally equivalent to a call to addch
      # followed by a call to refresh, a call to {waddch} followed by a call to
      # {wrefresh}, or a call to {waddch} followed by a call to {prefresh}.
      #
      # The knowledge that only a single character is being output is taken
      # into consideration and, for non-control characters, a considerable
      # performance gain might be seen by using these routines instead of their
      # equivalents.
      #
      # In the case of pechochar, the last location of the pad on the screen is
      # reused for the arguments to prefresh.
      def pechochar(char)
        Ncurses.pechochar(pointer, char)
      end

      # Analogous to {wrefresh}, except that it relates to pads instead of windows.
      #
      # The additional parameters are needed to indicate what part of the pad
      # and screen are involved.
      #
      # pminrow and pmincol specify the upper left-hand corner of the rectangle
      # to be displayed in the pad.
      #
      # sminrow, smincol, smaxrow, and smaxcol specify the edges of the
      # rectangle to be displayed on the screen.
      #
      # The lower right-hand corner of the rectangle to be displayed in the pad
      # is calculated from the screen coordinates, since the rectangles must be
      # the same size.
      # Both rectangles must be entirely contained within their respective
      # structures.
      # Negative values of pminrow, pmincol, sminrow, or smincol are treated as
      # if they were zero.
      def prefresh(pminrow, pmincol, sminrow, smincol, smaxrow, smaxcol)
        Ncurses.prefresh(pointer, pminrow, pmincol, sminrow, smincol, smaxrow, smaxcol)
      end

      # The ripoffline routine provides access to the same facility that
      # slk_init [see curs_slk(3X)] uses to reduce the size of the screen.
      #
      # ripoffline must be called before {initscr} or {newterm} is called.
      #
      # If line is positive, a line is removed from the top of stdscr; if line
      # is negative, a line is removed from the bottom.
      #
      # When this is done inside {initscr}, the routine init (supplied by the
      # user) is called with two arguments: a window pointer to the one-line
      # window that has been allocated and an integer with the number of
      # columns in the window.
      #
      # Inside this initialization routine, the integer variables LINES and
      # COLS (defined in <curses.h>) are not guaranteed to be accurate and
      # {wrefresh} or {doupdate} must not be called.
      #
      # It is allowable to call {wnoutrefresh} during the initialization
      # routine.
      #
      # ripoffline can be called up to five times before calling initscr or newterm.
      def ripoffline(line)
        Ncurses.ripoffline(line, pointer)
      end

      # Like {werase}, but also calls {clearok}, so that the screen is cleared
      # completely on the next call to {wrefresh} for this window, and
      # repainted from scratch.
      def wclear
        Ncurses.wclear(pointer)
      end

      # Erase from the cursor to the end of window.
      # That is, erase all lines below the cursor in the window.
      # Also, the current line to the right of the cursor, inclusive, is erased.
      def wclrtobot
        Ncurses.wclrtobot(pointer)
      end

      # Erase the current line to the right of the cursor, inclusive, to the
      # end of the current line.
      def wclrtoeol
        Ncurses.wclrtoeol(pointer)
      end

      # Delete the character under the cursor; all characters to the right of
      # the cursor on the same line are moved to the left one position and the
      # last character on the line is filled with a blank.
      #
      # The cursor position does not change
      #
      # (This does not imply use of the hardware delete character feature.)
      def wdelch
        Ncurses.wdelch(pointer)
      end

      # Copy blanks to every position in the window, clearing the screen.
      def werase
        Ncurses.werase(pointer)
      end

      # Read a character from the window.
      # In no-delay mode, if no input is waiting, the value ERR is returned.
      # In delay mode, the program waits until the system passes text through to the program.
      # Depending on the setting of {cbreak}, this is after one character (cbreak mode), or after the first newline (nocbreak mode).
      # In half-delay mode, the program waits until a character is typed or the specified timeout has been reached.
      def wgetch
        Ncurses.wgetch(pointer)
      end

      # Must be called to get actual output to the terminal, as other routines merely manipulate data structures.
      #
      # This method copies the window to the physical terminal screen, taking into account what is already there to do optimizations.
      #
      # Unless {leaveok} has been enabled, the physical cursor of the terminal is left at the location of the cursor for that window.
      #
      # This method works by first calling {wnoutrefresh}, which copies the
      # named window to the virtual screen, and then calling {doupdate}, which
      # compares the virtual screen to the physical screen and does the actual
      # update.
      #
      # The phrase "copies the named window to the virtual screen" above is ambiguous.
      #
      # What actually happens is that all touched (changed) lines in the window
      # are copied to the virtual screen.
      #
      # This affects programs that use overlapping windows; it means that if
      # two windows overlap, you can refresh them in either order and the
      # overlap region will be modified only when it is explicitly changed.
      def wrefresh
        Ncurses.wrefresh(pointer)
      end

      # If the programmer wishes to output several windows at once, a series of
      # calls to {wrefresh} results in alternating calls to {wnoutrefresh} and
      # {doupdate}, causing several bursts of output to the screen.
      #
      # By first calling {wnoutrefresh} for each window, it is then possible to
      # call {doupdate} once, resulting in only one burst of output, with fewer
      # total characters transmitted and less CPU time used.
      def wnoutrefresh
        Ncurses.wnoutrefresh(pointer)
      end

      # For positive n, scroll the window up n lines (line i+n becomes i);
      # otherwise scroll	the window down n lines.
      # This involves moving the lines in the window character image structure.
      # The current cursor position is not changed.
      def wscrl(n)
        Ncurses.wscrl(pointer, n)
      end

      def waddnstr(str, n)
        Ncurses.waddnstr(pointer, str, n)
      end

      def wcolor_set(color_pair_number)
        Ncurses.wcolor_set(pointer, color_pair_number, nil)
      end

      # Shorthand for {wborder}.
      #
      # +ver+ is the character for vertical lines, +hor+ the character for
      # horizontal lines.
      def box(ver, hor)
        ver = ver.respond_to?(:ord) ? ver.ord : ver
        hor = hor.respond_to?(:ord) ? hor.ord : hor

        Ncurses.box(pointer, ver, hor)
      end

      def mvwchgat(y, x, n, attr, color)
        Ncurses.mvwchgat(pointer, y, x, n, attr, color, nil)
      end

      # Reallocate storage for the window to adjust its dimensions to the
      # specified values.
      #
      # If either dimension islarger than the current values, the window's data
      # is filled with blanks that have the current background rendition (as
      # set by {wbkgndset} merged into them.
      def wresize(lines, cols)
        Ncurses.wresize(pointer, lines, cols)
      end

      # Delete the line under the cursor in the window.
      # All lines below the current line are moved up one line.
      # The bottom line of the window is cleared.
      # The cursor position does not change.
      def wdeleteln
        Ncurses.wdeleteln(pointer)
      end

      # Insert an empty line above the cursor in the window.
      # The bottom line in the window is lost.
      def winsertln
        Ncurses.winsertln(pointer)
      end

      def method_missing(name, *args)
        File.open('missing', 'a+'){|io|
          io.puts '=' * 80
          io.puts(`man #{name} | grep #{name}`)
          io.puts("def #{name}; end")
          io.puts '=' * 80
        }

        Ncurses.__send__(name, pointer, *args)
      end
    end
  end
end
