module VER
  module Methods
    module Open
      # TODO:
      # Binary files are still major fail.
      # We could try to copy behaviour of Vim or Emacs.
      # Some nice files for testing binary display are in /usr/share/terminfo
      #
      # About the nature of fail:
      # First of all, just about no font is made to have binary glyphs, even if it
      # would be nice to create a composite font, and would make editing a lot
      # nicer, it's really no option.
      #
      # Next issue is that some bytes that occur in binary files "\0" for example,
      # cause big problems for Tcl_EvalEx.
      #
      # I've tried sending the byte as:
      #   "\0", "\\0",
      #   "\x0", "\\x0",
      #   "\x00", "\\x00",
      #   "\u0000", "\\u0000"
      #
      # Tcl doesn't like that at all.
      # The first obviously sends the original \0 byte directly on, the second
      # displays in the widget as "\0", "\x0", and so on, which will lead to total
      # corruption.
      #
      # I have no idea how to work around this issue, must be some convention?
      # More important though, is to avoid sending those bytes at all, and it
      # seems to be a huge amount of work to get support for binary editing going.
      # There are much better tools for this around already, and maybe diluting
      # the normal Text buffer for this purpose will just make problems.
      #
      # For now, VER will simply fail to open files that contain \0 bytes, and
      # display binary files in a weird way.
      def open_path(path, line = 1)
        self.filename = path

        begin
          self.value = read_file(filename)
          message "Opened #{short_filename}"
        rescue Errno::ENOENT
          delete '1.0', :end
          message "Create #{short_filename}"
        end

        after_open(line)
      end

      # Read given file into memory and convert to @encoding
      def read_file(path)
        path = Pathname(path.to_s).expand_path
        encoding_name = encoding.name
        content = path.open("r:#{encoding_name}"){|io| io.read }

        unless content.valid_encoding? # take a guess
          @encoding = GUESS_ENCODING_ORDER.find{|enc|
            content.force_encoding(enc)
            content.valid_encoding?
          }

          # Now we have the source encoding, let's make it UTF-8 so Tcl can
          # handle it.
          content.force_encoding(@encoding)
          content.encode!(Encoding::UTF_8)
        end

        content.chomp
      end

      def open_empty
        delete '1.0', :end
        message "[No File]"
        after_open
      end

      def after_open(line = 1)
        VER.opened_file(self)

        edit_reset
        mark_set :insert, "#{line.to_i}.0"
        @pristine = false

        bind('<Map>') do
          defer do
            setup_highlight
            apply_modeline
          end
          bind('<Map>'){ see(:insert) }
        end
      end

      def apply_modeline
        if found = search(/\s+(?:vim?|ex):\s*.*$/, 1.0, :end, :count)
          pos, count = ["31.1", 24]
          p found1: found, pos: pos, count: count
          line = get(pos, "#{pos} + #{count} chars")
          line =~ /\s+(?:vim?|ex):\s*(.*)$/
          $1.split.each{|option| apply_modeline_option(option) }
        elsif found = search(/\s+(?:vim?|ex):[^:]+:/, 1.0)
          p found2: found
        elsif found = search(/^(?:vim?):[^:]+:/, 1.0)
          p found3: found
        end
      end

      def apply_modeline_option(option)
        negative = option.gsub!(/^no/, '')
        boolean = !negative

        case option
        when 'ai', 'autoindent'
          set :autoindent, boolean
        when 'et', 'expandtab'
          set :expandtab, boolean

          # In Insert mode: Use the appropriate number of spaces to insert a
          # <Tab>. Spaces are used in indents with the '>' and '<' commands and
          # when 'autoindent' is on.
          # To insert a real tab when 'expandtab' is on, use CTRL-V<Tab>.
          # See also |:retab| and |ins-expandtab|.
          # NOTE: This option is reset when 'compatible' is set.
        when /(?:tw|textwidth)=(\d+)/
          set :textwidth, $1.to_i
        when /(?:ts|tabstop)=(\d+)/
          set :tabstop, $1.to_i
        when /(?:sw|shiftwidth)=(\d+)/
          set :shiftwidth, $1.to_i

#          Number of spaces to use for each step of (auto)indent.  Used for
#          |'cindent'|, |>>|, |<<|, etc.
        when /(?:ft|filetype)=(\w+)/
          set(:filetype, $1) do |type|
            name = Syntax.from_filename(Pathname("foo.#{type}"))
            p load_syntax(name)
          end
        else
          p unknown_modeline_option: option
        end
      end

      attr_reader :options

      def set(option, value)
        @options ||= {}
        options[option] = value
        require 'pp'
        pp options
        yield(value) if block_given?
      end
    end
  end
end

=begin
There are two forms of modelines.  The first form:
	[text]{white}{vi:|vim:|ex:}[white]{options}

[text]		any text or empty
{white}		at least one blank character (<Space> or <Tab>)
{vi:|vim:|ex:}	the string "vi:", "vim:" or "ex:"
[white]		optional white space
{options}	a list of option settings, separated with white space or ':',
		where each part between ':' is the argument for a ":set"
		command (can be empty)

Example:
   vi:noai:sw=3 ts=6 ~

The second form (this is compatible with some versions of Vi):

	[text]{white}{vi:|vim:|ex:}[white]se[t] {options}:[text]

[text]		any text or empty
{white}		at least one blank character (<Space> or <Tab>)
{vi:|vim:|ex:}	the string "vi:", "vim:" or "ex:"
[white]		optional white space
se[t]		the string "set " or "se " (note the space)
{options}	a list of options, separated with white space, which is the
		argument for a ":set" command
:		a colon
[text]		any text or empty

Example:
   /* vim: set ai tw=75: */ ~

The white space before {vi:|vim:|ex:} is required.  This minimizes the chance
that a normal word like "lex:" is caught.  There is one exception: "vi:" and
"vim:" can also be at the start of the line (for compatibility with version
3.0).  Using "ex:" at the start of the line will be ignored (this could be
short for "example:").
=end
