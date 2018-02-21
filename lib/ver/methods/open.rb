module VER
  module Methods
    module Open
      GUESS_ENCODING_ORDER = [
        Encoding::US_ASCII,
        Encoding::UTF_8,
        Encoding::Shift_JIS,
        Encoding::EUC_JP,
        Encoding::EucJP_ms,
        Encoding::Big5,
        Encoding::UTF_16BE,
        Encoding::UTF_16LE,
        Encoding::UTF_32BE,
        Encoding::UTF_32LE,
        Encoding::CP949,
        Encoding::Emacs_Mule,
        Encoding::EUC_KR,
        Encoding::EUC_TW,
        Encoding::GB18030,
        Encoding::GBK,
        Encoding::Stateless_ISO_2022_JP,
        Encoding::CP51932,
        Encoding::EUC_CN,
        Encoding::GB12345,
        Encoding::Windows_31J,
        Encoding::MacJapanese,
        Encoding::UTF8_MAC,
        Encoding::BINARY
      ]

      module_function

      # Try to determine the file under the cursor.
      # This handles names without spaces if no quotes are found
      # quotes may be like '', "", [], {}, () <>
      # we also search for the file in a couple of common locations.
      # Since some programming languages allow omission of the
      # filename-extension, we assume that it's one of the extensions registered
      # for the current file type if nothing could be found otherwise.
      # if that fails, we try to use `locate`, which can yield good results.
      # if no file could be found it simply does nothing?
      def file_under_cursor(text)
        paths = %w[. lib ext /]
        head = text.get('insert linestart', 'insert')
        tail = text.get('insert', 'insert lineend')
        tail_index = tail.index(/['"\]})>]/) || tail.index(/\s/)
        return unless delim = $&

        head_index = head.rindex(delim)
        return unless tail_index && head_index

        base = [head[(head_index + 1)..-1], tail[0...tail_index]].join

        syntax_name = text.syntax.name if text.syntax
        exts = VER::Syntax::Detector::EXTS_LIST.fetch(syntax_name, [])

        found = catch(:found) do
          paths.map do |path|
            path_base = File.join(path, base)
            throw(:found, path_base) if File.file?(path_base)
            path_base
          end.each do |path_base|
            exts.each do |ext|
              path_base_ext = "#{path_base}.#{ext}"
              throw(:found, path_base_ext) if File.file?(path_base_ext)
            end
          end
          nil
        end
      end

      def open_file_under_cursor(text)
        return unless found = file_under_cursor(text)
        VER.find_or_create_buffer(found)
      end

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
      def open_path(text, path, line = 1, column = 0)
        text.filename = path

        begin
          text.clear
          content = read_file(text, text.filename)
          text.encoding = content.encoding
          text.readonly = !text.filename.writable?
          text.insert(1.0, content)
          text.message "Opened #{text.short_filename}"
        rescue Errno::ENOENT
          text.clear
          text.message("Created #{text.short_filename}")
        end

        after_open(text, line, column)
      end

      def open_symbolic(text, name, _line = 1, _column = 0)
        text.name = name
        text.clear

        case name
        when :Scratch
          text.insert(:insert, <<-TEXT)
# This buffer is for notes you don't want to save, and for Ruby evaluation.
# If you want to create a file, visit that file with :o.
# then enter the text in that file's own buffer.
          TEXT
          after_open(text, 1, 0, Syntax.new('Ruby'))
        when :Messages
          text.tag_configure(:info, foreground: '#aaf')
          text.tag_configure(:warn, foreground: '#faa')
          after_open(text, 1, 0, Syntax.new('Plain Text'))
        when :Completions
          text.major_mode = :Completions
          text.tag_configure('ver.minibuf.completion', foreground: '#00f')
          after_open(text, 1, 0, Syntax.new('Plain Text'))
        else
          after_open(text, 1, 0, Syntax.new('Plain Text'))
        end

        text.message "Created #{name}"
      end

      def open_empty(text)
        text.clear
        text.message '[No File]'
        after_open(text, 1, 0, Syntax.new('Plain Text'))
      end

      def file_open_popup(_text)
        filetypes = [
          ['ALL Files',  '*'],
          ['Text Files', '*.txt']
        ]

        fpath = Tk.get_open_file(filetypes: filetypes)

        return unless fpath

        VER.find_or_create_buffer(fpath)
      end

      def file_open_ask(text)
        path = Dir.pwd + '/'
        text.ask 'Filename: ', value: path do |answer, action|
          case action
          when :complete
            file_complete(answer)
          when :attempt
            VER.find_or_create_buffer(answer)
            :abort
          end
        end
      end

      def file_complete(answer)
        rel = answer.sub(/^.*\/\//, '/')
        rel = rel.sub(/^.*\/~\//, '~/')
        rel = File.expand_path(rel) unless File.directory?(rel)
        rel_size = rel.size

        choices = Dir.glob("#{rel}*").map do |path|
          if File.directory?(path)
            path[rel_size..-1] << '/'
          else
            path[rel_size..-1]
          end
        end

        common = nil
        choices.each do |path|
          path.size.times do |index|
            next if index == 0
            slice = path[0, index]

            if choices.all? { |choice| choice.start_with?(slice) }
              common = slice
            end
          end
        end

        if common
          only = answer + common

          if choices.size == 1
            choices.map { |choice| (answer + choice).sub(/\/+$/, '/') }
          elsif choices.size > 1
            [only]
          else
            if File.directory?(File.expand_path(only))
              [only]
            else
              [only]
            end
          end
        else
          choices.map { |choice| (answer + choice).sub(/\/+$/, '/') }
        end
      end

      # Read given file into memory and convert to @encoding
      def read_file(text, path)
        path = Pathname(path.to_s).expand_path
        encoding = text.encoding
        content = path.open("r:#{encoding.name}", &:read)

        unless content.valid_encoding? # take a guess
          GUESS_ENCODING_ORDER.find do |enc|
            content.force_encoding(enc)
            content.valid_encoding?
          end

          # Now we have the source encoding, let's make it UTF-8 so Tcl can
          # handle it.
          content.encode!(Encoding::UTF_8)
        end

        content.chomp
      end

      def after_open(text, line = 1, column = 0, syntax = nil)
        detect_project_paths(text)
        VER.opened_file(text)

        text.mark_set(:insert, "#{line.to_i}.#{column.to_i}")
        text.pristine = true

        text.undoer = VER::Undo::Tree.new(text)
        update_mtime(text)

        text.bind('<Map>') do
          VER.defer do
            syntax ? text.setup_highlight_for(syntax) : text.setup_highlight
            apply_modeline(text)
          end
          text.bind('<Map>') { text.see(:insert) }
        end
      end

      def update_mtime(text)
        return unless filename = text.filename
        text.store(:stat, :mtime, filename.mtime)
      rescue Errno::ENOENT
      end

      PROJECT_DIRECTORY_GLOB = '{.git/,.hg/,_darcs/,_FOSSIL_}'

      def detect_project_paths(text)
        return unless filename = text.filename
        parent = filename.expand_path.dirname

        begin
          (parent / PROJECT_DIRECTORY_GLOB).glob do |repo|
            text.project_repo = repo
            text.project_root = repo.dirname
            return
          end

          parent = parent.dirname
        end until parent.root?
      end

      MODELINES = {
        /\s+(?:ver|vim?|ex):\s*.*$/ => /\s+(?:ver|vim?|ex):\s*(.*)$/,
        /\s+(?:ver|vim?|ex):[^:]+:/ => /\s+(?:ver|vim?|ex):([^:]+):/,
        /^(?:ver|vim?):[^:]+:/      => /^(?:ver|vim?):([^:]+):/
      }

      def apply_modeline(text)
        MODELINES.each do |search_pattern, extract_pattern|
          found = text.search(search_pattern, 1.0, :end, :count)

          next if found.empty?

          pos, count = found
          # p found: found, pos: pos, count: count

          line = text.get(pos, "#{pos} + #{count} chars")
          # p line: line

          line =~ extract_pattern
          Regexp.last_match(1).scan(/[^:\s]+/) do |option|
            apply_modeline_option(text, option)
          end
        end
      end

      def apply_modeline_option(text, option)
        negative = option.gsub!(/^no/, '')
        boolean = !negative

        case option
        when 'ai', 'autoindent'
          set text, :autoindent, boolean
        when 'et', 'expandtab'
          set text, :expandtab, boolean
        when /(?:tw|textwidth)=(\d+)/
          set text, :textwidth, Regexp.last_match(1).to_i
        when /(?:ts|tabstop)=(\d+)/
          set text, :tabstop, Regexp.last_match(1).to_i
        when /(?:sw|shiftwidth)=(\d+)/
          set text, :shiftwidth, Regexp.last_match(1).to_i
        when /(?:ft|filetype)=(\w+)/
          set text, :filetype, Regexp.last_match(1)
        else
          l unknown_modeline_option: option
        end
      end

      def set(text, option, value)
        method = "set_#{option}"

        if respond_to?(method)
          if block_given?
            __send__(method, text, value, &Proc.new)
          else
            __send__(method, text, value)
          end
        else
          text.options[option] = value
          yield(text, value) if block_given?
        end
      end

      def set_filetype(type)
        syntax = VER::Syntax.from_filename(Pathname("foo.#{type}"))

        text.options.filetype = type if text.load_syntax(syntax)
      end
    end
  end
end
