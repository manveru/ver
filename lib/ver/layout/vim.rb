class Window
  # Split current window in two.
  # The result is two viewports on the same file.
  # Make new window N high (default is to use half the height of the current
  # window). Reduces the current window height to create room (and others, if
  # the 'equalalways' option is set, 'eadirection' isn't "hor", and one of the
  # mis higher than the current or the new window.
  def split_horizontal(n = nil); end

  # Like {split_horizontal}, but split vertically.
  def split_vertical(n = nil); end

  # Create a new window and start editing an empty file in it.
  # Make new window N high (default is to use half the existing height).
  # Reduces the current window height to create room.
  def new_horizontal(n = nil); end

  # Like {new_horizontal} but split vertically.
  def new_vertical(n = nil); end

  # Quit current window.
  # When quitting the last window (not counting symbolic ones), exit VER.
  # Asks before unsaved changes are abandoned.
  def quit; end

  # Same as {quit}, but doesn't ask if buffer was modified.
  def quit!; end

  # Close this window to hide it, asks if buffer was modified, will do nothing
  # if current window is last window on screen.
  def close; end

  # Same as {close}, but will not ask anything.
  def close!; end

  # Make this the only window on the screen. All other windows are {close}d.
  def only; end

  # Focus the nth window below.
  # Uses insert cursor position to select between alternatives.
  def go_below(n = nil); end

  # Focus the nth window above.
  # Uses insert cursor position to select between alternatives.
  def go_above(n = nil); end

  # Focus the nth window to the left.
  # Uses insert cursor position to select between alternatives.
  def go_left(n = nil); end

  # Focus the nth window to the right.
  # Uses insert cursor position to select between alternatives.
  def go_right(n = nil); end
end

__END__
CTRL-W w					*CTRL-W_w* *CTRL-W_CTRL-W*
CTRL-W CTRL-W	Without count: move cursor to window below/right of the
		current one.  If there is no window below or right, go to
		top-left window.
		With count: go to Nth window (windows are numbered from
		top-left to bottom-right).  To obtain the window number see
		|bufwinnr()| and |winnr()|.

						*CTRL-W_W*
CTRL-W W	Without count: move cursor to window above/left of current
		one.  If there is no window above or left, go to bottom-right
		window.  With count: go to Nth window (windows are numbered
		from top-left to bottom-right).

CTRL-W t					*CTRL-W_t* *CTRL-W_CTRL-T*
CTRL-W CTRL-T	Move cursor to top-left window.

CTRL-W b					*CTRL-W_b* *CTRL-W_CTRL-B*
CTRL-W CTRL-B	Move cursor to bottom-right window.

CTRL-W p					*CTRL-W_p* *CTRL-W_CTRL-P*
CTRL-W CTRL-P	Go to previous (last accessed) window.

						*CTRL-W_P* *E441*
CTRL-W P	Go to preview window.  When there is no preview window this is
		an error.
		{not available when compiled without the |+quickfix| feature}

If Visual mode is active and the new window is not for the same buffer, the
Visual mode is ended.  If the window is on the same buffer, the cursor
position is set to keep the same Visual area selected.

						*:winc* *:wincmd*
These commands can also be executed with ":wincmd":

:[count]winc[md] {arg}
		Like executing CTRL-W [count] {arg}.  Example: >
			:wincmd j
<		Moves to the window below the current one.
		This command is useful when a Normal mode cannot be used (for
		the |CursorHold| autocommand event).  Or when a Normal mode
		command is inconvenient.
		The count can also be a window number.  Example: >
			:exe nr . "wincmd w"
<		This goes to window "nr".

==============================================================================
5. Moving windows around				*window-moving*

CTRL-W r				*CTRL-W_r* *CTRL-W_CTRL-R* *E443*
CTRL-W CTRL-R	Rotate windows downwards/rightwards.  The first window becomes
		the second one, the second one becomes the third one, etc.
		The last window becomes the first window.  The cursor remains
		in the same window.
		This only works within the row or column of windows that the
		current window is in.

						*CTRL-W_R*
CTRL-W R	Rotate windows upwards/leftwards.  The second window becomes
		the first one, the third one becomes the second one, etc.  The
		first window becomes the last window.  The cursor remains in
		the same window.
		This only works within the row or column of windows that the
		current window is in.

CTRL-W x					*CTRL-W_x* *CTRL-W_CTRL-X*
CTRL-W CTRL-X	Without count: Exchange current window with next one.  If there
		is no next window, exchange with previous window.
		With count: Exchange current window with Nth window (first
		window is 1).  The cursor is put in the other window.
		When vertical and horizontal window splits are mixed, the
		exchange is only done in the row or column of windows that the
		current window is in.

The following commands can be used to change the window layout.  For example,
when there are two vertically split windows, CTRL-W K will change that in
horizontally split windows.  CTRL-W H does it the other way around.

						*CTRL-W_K*
CTRL-W K	Move the current window to be at the very top, using the full
		width of the screen.  This works like closing the current
		window and then creating another one with ":topleft split",
		except that the current window contents is used for the new
		window.

						*CTRL-W_J*
CTRL-W J	Move the current window to be at the very bottom, using the
		full width of the screen.  This works like closing the current
		window and then creating another one with ":botright split",
		except that the current window contents is used for the new
		window.

						*CTRL-W_H*
CTRL-W H	Move the current window to be at the far left, using the
		full height of the screen.  This works like closing the
		current window and then creating another one with
		":vert topleft split", except that the current window contents
		is used for the new window.
		{not available when compiled without the +vertsplit feature}

						*CTRL-W_L*
CTRL-W L	Move the current window to be at the far right, using the full
		height of the screen.  This works like closing the
		current window and then creating another one with
		":vert botright split", except that the current window
		contents is used for the new window.
		{not available when compiled without the +vertsplit feature}

						*CTRL-W_T*
CTRL-W T	Move the current window to a new tab page.  This fails if
		there is only one window in the current tab page.
		When a count is specified the new tab page will be opened
		before the tab page with this index.  Otherwise it comes after
		the current tab page.

==============================================================================
6. Window resizing					*window-resize*

						*CTRL-W_=*
CTRL-W =	Make all windows (almost) equally high and wide, but use
		'winheight' and 'winwidth' for the current window.
		Windows with 'winfixheight' set keep their height and windows
		with 'winfixwidth' set keep their width.

:res[ize] -N					*:res* *:resize* *CTRL-W_-*
CTRL-W -	Decrease current window height by N (default 1).
		If used after 'vertical': decrease width by N.

:res[ize] +N					*CTRL-W_+*
CTRL-W +	Increase current window height by N (default 1).
		If used after 'vertical': increase width by N.

:res[ize] [N]
CTRL-W CTRL-_					*CTRL-W_CTRL-_* *CTRL-W__*
CTRL-W _	Set current window height to N (default: highest possible).

z{nr}<CR>	Set current window height to {nr}.

						*CTRL-W_<*
CTRL-W <	Decrease current window width by N (default 1).

						*CTRL-W_>*
CTRL-W >	Increase current window width by N (default 1).

:vertical res[ize] [N]			*:vertical-resize* *CTRL-W_bar*
CTRL-W |	Set current window width to N (default: widest possible).

You can also resize a window by dragging a status line up or down with the
mouse.  Or by dragging a vertical separator line left or right.  This only
works if the version of Vim that is being used supports the mouse and the
'mouse' option has been set to enable it.

The option 'winheight' ('wh') is used to set the minimal window height of the
current window.  This option is used each time another window becomes the
current window.  If the option is '0', it is disabled.  Set 'winheight' to a
very large value, e.g., '9999', to make the current window always fill all
available space.  Set it to a reasonable value, e.g., '10', to make editing in
the current window comfortable.

The equivalent 'winwidth' ('wiw') option is used to set the minimal width of
the current window.

When the option 'equalalways' ('ea') is set, all the windows are automatically
made the same size after splitting or closing a window.  If you don't set this
option, splitting a window will reduce the size of the current window and
leave the other windows the same.  When closing a window, the extra lines are
given to the window above it.

The 'eadirection' option limits the direction in which the 'equalalways'
option is applied.  The default "both" resizes in both directions.  When the
value is "ver" only the heights of windows are equalized.  Use this when you
have manually resized a vertically split window and want to keep this width.
Likewise, "hor" causes only the widths of windows to be equalized.

The option 'cmdheight' ('ch') is used to set the height of the command-line.
If you are annoyed by the |hit-enter| prompt for long messages, set this
option to 2 or 3.

If there is only one window, resizing that window will also change the command
line height.  If there are several windows, resizing the current window will
also change the height of the window below it (and sometimes the window above
it).

The minimal height and width of a window is set with 'winminheight' and
'winminwidth'.  These are hard values, a window will never become smaller.

==============================================================================
7. Argument and buffer list commands			*buffer-list*

      args list		       buffer list	   meaning ~
1. :[N]argument [N]	11. :[N]buffer [N]	to arg/buf N
2. :[N]next [file ..]	12. :[N]bnext [N]	to Nth next arg/buf
3. :[N]Next [N]		13. :[N]bNext [N]	to Nth previous arg/buf
4. :[N]previous	[N]	14. :[N]bprevious [N]	to Nth previous arg/buf
5. :rewind / :first	15. :brewind / :bfirst	to first arg/buf
6. :last		16. :blast		to last arg/buf
7. :all			17. :ball		edit all args/buffers
			18. :unhide		edit all loaded buffers
			19. :[N]bmod [N]	to Nth modified buf

  split & args list	  split & buffer list	   meaning ~
21. :[N]sargument [N]   31. :[N]sbuffer [N]	split + to arg/buf N
22. :[N]snext [file ..] 32. :[N]sbnext [N]      split + to Nth next arg/buf
23. :[N]sNext [N]       33. :[N]sbNext [N]      split + to Nth previous arg/buf
24. :[N]sprevious [N]   34. :[N]sbprevious [N]  split + to Nth previous arg/buf
25. :srewind / :sfirst	35. :sbrewind / :sbfirst split + to first arg/buf
26. :slast		36. :sblast		split + to last arg/buf
27. :sall		37. :sball		edit all args/buffers
			38. :sunhide		edit all loaded buffers
			39. :[N]sbmod [N]	split + to Nth modified buf

40. :args		list of arguments
41. :buffers		list of buffers

The meaning of [N] depends on the command:
 [N] is number of buffers to go forward/backward on ?2, ?3, and ?4
 [N] is an argument number, defaulting to current argument, for 1 and 21
 [N] is a buffer number, defaulting to current buffer, for 11 and 31
 [N] is a count for 19 and 39

Note: ":next" is an exception, because it must accept a list of file names
for compatibility with Vi.


The argument list and multiple windows
--------------------------------------

The current position in the argument list can be different for each window.
Remember that when doing ":e file", the position in the argument list stays
the same, but you are not editing the file at that position.  To indicate
this, the file message (and the title, if you have one) shows
"(file (N) of M)", where "(N)" is the current position in the file list, and
"M" the number of files in the file list.

All the entries in the argument list are added to the buffer list.  Thus, you
can also get to them with the buffer list commands, like ":bnext".

:[N]al[l][!] [N]				*:al* *:all* *:sal* *:sall*
:[N]sal[l][!] [N]
		Rearrange the screen to open one window for each argument.
		All other windows are closed.  When a count is given, this is
		the maximum number of windows to open.
		With the |:tab| modifier open a tab page for each argument.
		When there are more arguments than 'tabpagemax' further ones
		become split windows in the last tab page.
		When the 'hidden' option is set, all buffers in closed windows
		become hidden.
		When 'hidden' is not set, and the 'autowrite' option is set,
		modified buffers are written.  Otherwise, windows that have
		buffers that are modified are not removed, unless the [!] is
		given, then they become hidden.  But modified buffers are
		never abandoned, so changes cannot get lost.
		[N] is the maximum number of windows to open.  'winheight'
		also limits the number of windows opened ('winwidth' if
		|:vertical| was prepended).
		Buf/Win Enter/Leave autocommands are not executed for the new
		windows here, that's only done when they are really entered.

:[N]sa[rgument][!] [++opt] [+cmd] [N]			*:sa* *:sargument*
		Short for ":split | argument [N]": split window and go to Nth
		argument.  But when there is no such argument, the window is
		not split.  Also see |++opt| and |+cmd|.

:[N]sn[ext][!] [++opt] [+cmd] [file ..]			*:sn* *:snext*
		Short for ":split | [N]next": split window and go to Nth next
		argument.  But when there is no next file, the window is not
		split.  Also see |++opt| and |+cmd|.

:[N]spr[evious][!] [++opt] [+cmd] [N]			*:spr* *:sprevious*
:[N]sN[ext][!] [++opt] [+cmd] [N]			*:sN* *:sNext*
		Short for ":split | [N]Next": split window and go to Nth
		previous argument.  But when there is no previous file, the
		window is not split.  Also see |++opt| and |+cmd|.

						*:sre* *:srewind*
:sre[wind][!] [++opt] [+cmd]
		Short for ":split | rewind": split window and go to first
		argument.  But when there is no argument list, the window is
		not split.  Also see |++opt| and |+cmd|.

						*:sfir* *:sfirst*
:sfir[st] [++opt] [+cmd]
		Same as ":srewind".

						*:sla* *:slast*
:sla[st][!] [++opt] [+cmd]
		Short for ":split | last": split window and go to last
		argument.  But when there is no argument list, the window is
		not split.  Also see |++opt| and |+cmd|.

						*:dr* *:drop*
:dr[op] [++opt] [+cmd] {file} ..
		Edit the first {file} in a window.
		- If the file is already open in a window change to that
		  window.
		- If the file is not open in a window edit the file in the
		  current window.  If the current buffer can't be |abandon|ed,
		  the window is split first.
		The |argument-list| is set, like with the |:next| command.
		The purpose of this command is that it can be used from a
		program that wants Vim to edit another file, e.g., a debugger.
		When using the |:tab| modifier each argument is opened in a
		tab page.  The last window is used if it's empty.
		Also see |++opt| and |+cmd|.
		{only available when compiled with the +gui feature}

==============================================================================
8. Do a command in all buffers or windows			*list-repeat*

							*:windo*
:windo {cmd}		Execute {cmd} in each window.
			It works like doing this: >
				CTRL-W t
				:{cmd}
				CTRL-W w
				:{cmd}
				etc.
<			This only operates in the current tab page.
			When an error is detected on one window, further
			windows will not be visited.
			The last window (or where an error occurred) becomes
			the current window.
			{cmd} can contain '|' to concatenate several commands.
			{cmd} must not open or close windows or reorder them.
			{not in Vi} {not available when compiled without the
			|+listcmds| feature}
			Also see |:tabdo|, |:argdo| and |:bufdo|.

							*:bufdo*
:bufdo[!] {cmd}		Execute {cmd} in each buffer in the buffer list.
			It works like doing this: >
				:bfirst
				:{cmd}
				:bnext
				:{cmd}
				etc.
<			When the current file can't be |abandon|ed and the [!]
			is not present, the command fails.
			When an error is detected on one buffer, further
			buffers will not be visited.
			Unlisted buffers are skipped.
			The last buffer (or where an error occurred) becomes
			the current buffer.
			{cmd} can contain '|' to concatenate several commands.
			{cmd} must not delete buffers or add buffers to the
			buffer list.
			Note: While this command is executing, the Syntax
			autocommand event is disabled by adding it to
			'eventignore'.  This considerably speeds up editing
			each buffer.
			{not in Vi} {not available when compiled without the
			|+listcmds| feature}
			Also see |:tabdo|, |:argdo| and |:windo|.

Examples: >

	:windo set nolist nofoldcolumn | normal zn

This resets the 'list' option and disables folding in all windows. >

	:bufdo set fileencoding= | update

This resets the 'fileencoding' in each buffer and writes it if this changed
the buffer.  The result is that all buffers will use the 'encoding' encoding
(if conversion works properly).

==============================================================================
9. Tag or file name under the cursor			*window-tag*

							*:sta* *:stag*
:sta[g][!] [tagname]
		Does ":tag[!] [tagname]" and splits the window for the found
		tag.  See also |:tag|.

CTRL-W ]					*CTRL-W_]* *CTRL-W_CTRL-]*
CTRL-W CTRL-]	Split current window in two.  Use identifier under cursor as a
		tag and jump to it in the new upper window.  Make new window N
		high.

							*CTRL-W_g]*
CTRL-W g ]	Split current window in two.  Use identifier under cursor as a
		tag and perform ":tselect" on it in the new upper window.
		Make new window N high.

							*CTRL-W_g_CTRL-]*
CTRL-W g CTRL-]	Split current window in two.  Use identifier under cursor as a
		tag and perform ":tjump" on it in the new upper window.  Make
		new window N high.

CTRL-W f					*CTRL-W_f* *CTRL-W_CTRL-F*
CTRL-W CTRL-F	Split current window in two.  Edit file name under cursor.
		Like ":split gf", but window isn't split if the file does not
		exist.
		Uses the 'path' variable as a list of directory names where to
		look for the file.  Also the path for current file is
		used to search for the file name.
		If the name is a hypertext link that looks like
		"type://machine/path", only "/path" is used.
		If a count is given, the count'th matching file is edited.
		{not available when the |+file_in_path| feature was disabled
		at compile time}

CTRL-W F						*CTRL-W_F*
		Split current window in two.  Edit file name under cursor and
		jump to the line number following the file name. See |gF| for
		details on how the line number is obtained.
		{not available when the |+file_in_path| feature was disabled
		at compile time}

CTRL-W gf						*CTRL-W_gf*
		Open a new tab page and edit the file name under the cursor.
		Like "tab split" and "gf", but the new tab page isn't created
		if the file does not exist.
		{not available when the |+file_in_path| feature was disabled
		at compile time}

CTRL-W gF						*CTRL-W_gF*
		Open a new tab page and edit the file name under the cursor
		and jump to the line number following the file name.  Like
		"tab split" and "gF", but the new tab page isn't created if
		the file does not exist.
		{not available when the |+file_in_path| feature was disabled
		at compile time}

Also see |CTRL-W_CTRL-I|: open window for an included file that includes
the keyword under the cursor.

==============================================================================
10. The preview window				*preview-window*

The preview window is a special window to show (preview) another file.  It is
normally a small window used to show an include file or definition of a
function.
{not available when compiled without the |+quickfix| feature}

There can be only one preview window (per tab page).  It is created with one
of the commands below.  The 'previewheight' option can be set to specify the
height of the preview window when it's opened.  The 'previewwindow' option is
set in the preview window to be able to recognize it.  The 'winfixheight'
option is set to have it keep the same height when opening/closing other
windows.

						*:pta* *:ptag*
:pta[g][!] [tagname]
		Does ":tag[!] [tagname]" and shows the found tag in a
		"Preview" window without changing the current buffer or cursor
		position.  If a "Preview" window already exists, it is re-used
		(like a help window is).  If a new one is opened,
		'previewheight' is used for the height of the window.   See
		also |:tag|.
		See below for an example. |CursorHold-example|
		Small difference from |:tag|: When [tagname] is equal to the
		already displayed tag, the position in the matching tag list
		is not reset.  This makes the CursorHold example work after a
		|:ptnext|.

CTRL-W z					*CTRL-W_z*
CTRL-W CTRL-Z					*CTRL-W_CTRL-Z* *:pc* *:pclose*
:pc[lose][!]	Close any "Preview" window currently open.  When the 'hidden'
		option is set, or when the buffer was changed and the [!] is
		used, the buffer becomes hidden (unless there is another
		window editing it).  The command fails if any "Preview" buffer
		cannot be closed.  See also |:close|.

							*:pp* *:ppop*
:[count]pp[op][!]
		Does ":[count]pop[!]" in the preview window.  See |:pop| and
		|:ptag|.  {not in Vi}

CTRL-W }						*CTRL-W_}*
		Use identifier under cursor as a tag and perform a :ptag on
		it.  Make the new Preview window (if required) N high.  If N is
		not given, 'previewheight' is used.

CTRL-W g }						*CTRL-W_g}*
		Use identifier under cursor as a tag and perform a :ptjump on
		it.  Make the new Preview window (if required) N high.  If N is
		not given, 'previewheight' is used.

							*:ped* *:pedit*
:ped[it][!] [++opt] [+cmd] {file}
		Edit {file} in the preview window.  The preview window is
		opened like with |:ptag|.  The current window and cursor
		position isn't changed.  Useful example: >
			:pedit +/fputc /usr/include/stdio.h
<
							*:ps* *:psearch*
:[range]ps[earch][!] [count] [/]pattern[/]
		Works like |:ijump| but shows the found match in the preview
		window.  The preview window is opened like with |:ptag|.  The
		current window and cursor position isn't changed.  Useful
		example: >
			:psearch popen
<		Like with the |:ptag| command, you can use this to
		automatically show information about the word under the
		cursor.  This is less clever than using |:ptag|, but you don't
		need a tags file and it will also find matches in system
		include files.  Example: >
  :au! CursorHold *.[ch] nested exe "silent! psearch " . expand("<cword>")
<		Warning: This can be slow.

Example						*CursorHold-example*  >

  :au! CursorHold *.[ch] nested exe "silent! ptag " . expand("<cword>")

This will cause a ":ptag" to be executed for the keyword under the cursor,
when the cursor hasn't moved for the time set with 'updatetime'.  The "nested"
makes other autocommands be executed, so that syntax highlighting works in the
preview window.  The "silent!" avoids an error message when the tag could not
be found.  Also see |CursorHold|.  To disable this again: >

  :au! CursorHold

A nice addition is to highlight the found tag, avoid the ":ptag" when there
is no word under the cursor, and a few other things: >

  :au! CursorHold *.[ch] nested call PreviewWord()
  :func PreviewWord()
  :  if &previewwindow			" don't do this in the preview window
  :    return
  :  endif
  :  let w = expand("<cword>")		" get the word under cursor
  :  if w =~ '\a'			" if the word contains a letter
  :
  :    " Delete any existing highlight before showing another tag
  :    silent! wincmd P			" jump to preview window
  :    if &previewwindow			" if we really get there...
  :      match none			" delete existing highlight
  :      wincmd p			" back to old window
  :    endif
  :
  :    " Try displaying a matching tag for the word under the cursor
  :    try
  :       exe "ptag " . w
  :    catch
  :      return
  :    endtry
  :
  :    silent! wincmd P			" jump to preview window
  :    if &previewwindow		" if we really get there...
  :	 if has("folding")
  :	   silent! .foldopen		" don't want a closed fold
  :	 endif
  :	 call search("$", "b")		" to end of previous line
  :	 let w = substitute(w, '\\', '\\\\', "")
  :	 call search('\<\V' . w . '\>')	" position cursor on match
  :	 " Add a match highlight to the word at this position
  :      hi previewWord term=bold ctermbg=green guibg=green
  :	 exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
  :      wincmd p			" back to old window
  :    endif
  :  endif
  :endfun

==============================================================================
11. Using hidden buffers				*buffer-hidden*

A hidden buffer is not displayed in a window, but is still loaded into memory.
This makes it possible to jump from file to file, without the need to read or
write the file every time you get another buffer in a window.
{not available when compiled without the |+listcmds| feature}

							*:buffer-!*
If the option 'hidden' ('hid') is set, abandoned buffers are kept for all
commands that start editing another file: ":edit", ":next", ":tag", etc.  The
commands that move through the buffer list sometimes make the current buffer
hidden although the 'hidden' option is not set.  This happens when a buffer is
modified, but is forced (with '!') to be removed from a window, and
'autowrite' is off or the buffer can't be written.

You can make a hidden buffer not hidden by starting to edit it with any
command.  Or by deleting it with the ":bdelete" command.

The 'hidden' is global, it is used for all buffers.  The 'bufhidden' option
can be used to make an exception for a specific buffer.  It can take these
values:
	<empty>		Use the value of 'hidden'.
	hide		Hide this buffer, also when 'hidden' is not set.
	unload		Don't hide but unload this buffer, also when 'hidden'
			is set.
	delete		Delete the buffer.

							*hidden-quit*
When you try to quit Vim while there is a hidden, modified buffer, you will
get an error message and Vim will make that buffer the current buffer.  You
can then decide to write this buffer (":wq") or quit without writing (":q!").
Be careful: there may be more hidden, modified buffers!

A buffer can also be unlisted.  This means it exists, but it is not in the
list of buffers. |unlisted-buffer|


:files[!]					*:files*
:buffers[!]					*:buffers* *:ls*
:ls[!]		Show all buffers.  Example:

			1 #h  "/test/text"		line 1 ~
			2u    "asdf"			line 0 ~
			3 %a+ "version.c"		line 1 ~

		When the [!] is included the list will show unlisted buffers
		(the term "unlisted" is a bit confusing then...).

		Each buffer has a unique number.  That number will not change,
		so you can always go to a specific buffer with ":buffer N" or
		"N CTRL-^", where N is the buffer number.

		Indicators (chars in the same column are mutually exclusive):
		u	an unlisted buffer (only displayed when [!] is used)
			   |unlisted-buffer|
		 %	the buffer in the current window
		 #	the alternate buffer for ":e #" and CTRL-^
		  a	an active buffer: it is loaded and visible
		  h	a hidden buffer: It is loaded, but currently not
			   displayed in a window |hidden-buffer|
		   -	a buffer with 'modifiable' off
		   =	a readonly buffer
		    +	a modified buffer
		    x   a buffer with read errors

						*:bad* *:badd*
:bad[d]	[+lnum] {fname}
		Add file name {fname} to the buffer list, without loading it.
		If "lnum" is specified, the cursor will be positioned at that
		line when the buffer is first entered.  Note that other
		commands after the + will be ignored.

:[N]bd[elete][!]			*:bd* *:bdel* *:bdelete* *E516*
:bd[elete][!] [N]
		Unload buffer [N] (default: current buffer) and delete it from
		the buffer list.  If the buffer was changed, this fails,
		unless when [!] is specified, in which case changes are lost.
		The file remains unaffected.  Any windows for this buffer are
		closed.  If buffer [N] is the current buffer, another buffer
		will be displayed instead.  This is the most recent entry in
		the jump list that points into a loaded buffer.
		Actually, the buffer isn't completely deleted, it is removed
		from the buffer list |unlisted-buffer| and option values,
		variables and mappings/abbreviations for the buffer are
		cleared.

:bdelete[!] {bufname}						*E93* *E94*
		Like ":bdelete[!] [N]", but buffer given by name.  Note that a
		buffer whose name is a number cannot be referenced by that
		name; use the buffer number instead.  Insert a backslash
		before a space in a buffer name.

:bdelete[!] N1 N2 ...
		Do ":bdelete[!]" for buffer N1, N2, etc.  The arguments can be
		buffer numbers or buffer names (but not buffer names that are
		a number).  Insert a backslash before a space in a buffer
		name.

:N,Mbdelete[!]	Do ":bdelete[!]" for all buffers in the range N to M
		|inclusive|.

:[N]bw[ipeout][!]			*:bw* *:bwipe* *:bwipeout* *E517*
:bw[ipeout][!] {bufname}
:N,Mbw[ipeout][!]
:bw[ipeout][!] N1 N2 ...
		Like |:bdelete|, but really delete the buffer.  Everything
		related to the buffer is lost.  All marks in this buffer
		become invalid, option settings are lost, etc.  Don't use this
		unless you know what you are doing.

:[N]bun[load][!]				*:bun* *:bunload* *E515*
:bun[load][!] [N]
		Unload buffer [N] (default: current buffer).  The memory
		allocated for this buffer will be freed.  The buffer remains
		in the buffer list.
		If the buffer was changed, this fails, unless when [!] is
		specified, in which case the changes are lost.
		Any windows for this buffer are closed.  If buffer [N] is the
		current buffer, another buffer will be displayed instead.
		This is the most recent entry in the jump list that points
		into a loaded buffer.

:bunload[!] {bufname}
		Like ":bunload[!] [N]", but buffer given by name.  Note that a
		buffer whose name is a number cannot be referenced by that
		name; use the buffer number instead.  Insert a backslash
		before a space in a buffer name.

:N,Mbunload[!]	Do ":bunload[!]" for all buffers in the range N to M
		|inclusive|.

:bunload[!] N1 N2 ...
		Do ":bunload[!]" for buffer N1, N2, etc.  The arguments can be
		buffer numbers or buffer names (but not buffer names that are
		a number).  Insert a backslash before a space in a buffer
		name.

:[N]b[uffer][!] [N]			*:b* *:bu* *:buf* *:buffer* *E86*
		Edit buffer [N] from the buffer list.  If [N] is not given,
		the current buffer remains being edited.  See |:buffer-!| for
		[!].  This will also edit a buffer that is not in the buffer
		list, without setting the 'buflisted' flag.

:[N]b[uffer][!] {bufname}
		Edit buffer for {bufname} from the buffer list.  See
		|:buffer-!| for [!].  This will also edit a buffer that is not
		in the buffer list, without setting the 'buflisted' flag.

:[N]sb[uffer] [N]					*:sb* *:sbuffer*
		Split window and edit buffer [N] from the buffer list.  If [N]
		is not given, the current buffer is edited.  Respects the
		"useopen" setting of 'switchbuf' when splitting.  This will
		also edit a buffer that is not in the buffer list, without
		setting the 'buflisted' flag.

:[N]sb[uffer] {bufname}
		Split window and edit buffer for {bufname} from the buffer
		list.  This will also edit a buffer that is not in the buffer
		list, without setting the 'buflisted' flag.
		Note: If what you want to do is split the buffer, make a copy
		under another name, you can do it this way: >
			:w foobar | sp #

:[N]bn[ext][!] [N]					*:bn* *:bnext* *E87*
		Go to [N]th next buffer in buffer list.  [N] defaults to one.
		Wraps around the end of the buffer list.
		See |:buffer-!| for [!].
		If you are in a help buffer, this takes you to the next help
		buffer (if there is one).  Similarly, if you are in a normal
		(non-help) buffer, this takes you to the next normal buffer.
		This is so that if you have invoked help, it doesn't get in
		the way when you're browsing code/text buffers.  The next three
		commands also work like this.

							*:sbn* *:sbnext*
:[N]sbn[ext] [N]
		Split window and go to [N]th next buffer in buffer list.
		Wraps around the end of the buffer list.  Uses 'switchbuf'

:[N]bN[ext][!] [N]			*:bN* *:bNext* *:bp* *:bprevious* *E88*
:[N]bp[revious][!] [N]
		Go to [N]th previous buffer in buffer list.  [N] defaults to
		one.  Wraps around the start of the buffer list.
		See |:buffer-!| for [!] and 'switchbuf'.

:[N]sbN[ext] [N]			*:sbN* *:sbNext* *:sbp* *:sbprevious*
:[N]sbp[revious] [N]
		Split window and go to [N]th previous buffer in buffer list.
		Wraps around the start of the buffer list.
		Uses 'switchbuf'.

							*:br* *:brewind*
:br[ewind][!]	Go to first buffer in buffer list.  If the buffer list is
		empty, go to the first unlisted buffer.
		See |:buffer-!| for [!].

							*:bf* *:bfirst*
:bf[irst]	Same as ":brewind".

							*:sbr* *:sbrewind*
:sbr[ewind]	Split window and go to first buffer in buffer list.  If the
		buffer list is empty, go to the first unlisted buffer.
		Respects the 'switchbuf' option.

							*:sbf* *:sbfirst*
:sbf[irst]	Same as ":sbrewind".

							*:bl* *:blast*
:bl[ast][!]	Go to last buffer in buffer list.  If the buffer list is
		empty, go to the last unlisted buffer.
		See |:buffer-!| for [!].

							*:sbl* *:sblast*
:sbl[ast]	Split window and go to last buffer in buffer list.  If the
		buffer list is empty, go to the last unlisted buffer.
		Respects 'switchbuf' option.

:[N]bm[odified][!] [N]				*:bm* *:bmodified* *E84*
		Go to [N]th next modified buffer.  Note: this command also
		finds unlisted buffers.  If there is no modified buffer the
		command fails.

:[N]sbm[odified] [N]					*:sbm* *:sbmodified*
		Split window and go to [N]th next modified buffer.
		Respects 'switchbuf' option.
		Note: this command also finds buffers not in the buffer list.

:[N]unh[ide] [N]			*:unh* *:unhide* *:sun* *:sunhide*
:[N]sun[hide] [N]
		Rearrange the screen to open one window for each loaded buffer
		in the buffer list.  When a count is given, this is the
		maximum number of windows to open.

:[N]ba[ll] [N]					*:ba* *:ball* *:sba* *:sball*
:[N]sba[ll] [N]	Rearrange the screen to open one window for each buffer in
		the buffer list.  When a count is given, this is the maximum
		number of windows to open.  'winheight' also limits the number
		of windows opened ('winwidth' if |:vertical| was prepended).
		Buf/Win Enter/Leave autocommands are not executed for the new
		windows here, that's only done when they are really entered.
		When the |:tab| modifier is used new windows are opened in a
		new tab, up to 'tabpagemax'.

Note: All the commands above that start editing another buffer, keep the
'readonly' flag as it was.  This differs from the ":edit" command, which sets
the 'readonly' flag each time the file is read.

==============================================================================
12. Special kinds of buffers			*special-buffers*

Instead of containing the text of a file, buffers can also be used for other
purposes.  A few options can be set to change the behavior of a buffer:
	'bufhidden'	what happens when the buffer is no longer displayed
			in a window.
	'buftype'	what kind of a buffer this is
	'swapfile'	whether the buffer will have a swap file
	'buflisted'	buffer shows up in the buffer list

A few useful kinds of a buffer:

quickfix	Used to contain the error list or the location list.  See
		|:cwindow| and |:lwindow|.  This command sets the 'buftype'
		option to "quickfix".  You are not supposed to change this!
		'swapfile' is off.

help		Contains a help file.  Will only be created with the |:help|
		command.  The flag that indicates a help buffer is internal
		and can't be changed.  The 'buflisted' option will be reset
		for a help buffer.

directory	Displays directory contents.  Can be used by a file explorer
		plugin.  The buffer is created with these settings: >
			:setlocal buftype=nowrite
			:setlocal bufhidden=delete
			:setlocal noswapfile
<		The buffer name is the name of the directory and is adjusted
		when using the |:cd| command.

scratch		Contains text that can be discarded at any time.  It is kept
		when closing the window, it must be deleted explicitly.
		Settings: >
			:setlocal buftype=nofile
			:setlocal bufhidden=hide
			:setlocal noswapfile
<		The buffer name can be used to identify the buffer.

						*unlisted-buffer*
unlisted	The buffer is not in the buffer list.  It is not used for
		normal editing, but to show a help file, remember a file name
		or marks.  The ":bdelete" command will also set this option,
		thus it doesn't completely delete the buffer.  Settings: >
			:setlocal nobuflisted
<

 vim:tw=78:ts=8:ft=help:norl:
