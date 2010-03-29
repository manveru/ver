module VER
  class Text
    class Selection < Tag
      autoload :Char, 'ver/text/selection/char'
      autoload :Line, 'ver/text/selection/line'
      autoload :Block, 'ver/text/selection/block'

      def self.enter(buffer, old_mode, new_mode)
        buffer.at_sel.enter(old_mode, new_mode)
      end

      def self.leave(buffer, old_mode, new_mode)
        buffer.at_sel.leave(old_mode, new_mode)
      end

      attr_accessor :mode
      attr_reader :anchor

      def initialize(buffer, refresh = true, mode = :select_char)
        super(buffer, :sel)
        @mode = mode
        @anchor = buffer.mark(:sel_anchor)
        refresh() if @refresh = refresh
      end

      # This is called when the minor mode changes.
      def enter(old_mode, new_mode)
        reset unless old_mode.name =~ /^select_/
        enter_mode(new_mode.name)
      end

      def enter_mode(mode_name)
        buffer.at_sel = sel =
          case mode_name
          when /^select_char/;  Char.new(buffer)
          when /^select_line/;  Line.new(buffer)
          when /^select_block/; Block.new(buffer)
          else; raise ArgumentError, "Unknown mode: %p"
          end

        sel.mode = mode_name.to_sym
      end

      # This is called when the minor mode changes.
      def leave(old_mode, new_mode)
        return if new_mode.name =~ /^select/
        @refresh = false
        clear
        anchor.unset
      end

      def reset
        clear
        anchor.index = :insert
      end

      def clear
        tag_remove('1.0', 'end')
      end

      # Enter control mode, indirectly invokes {leave}.
      def finish
        buffer.minor_mode(mode, :control)
      end

      # Using delete, since the sel tag cannot be deleted anyway.
      def delete
        buffer.undo_record do |record|
          ranges = []
          each_range{|range| ranges.push(*range) }
          record.delete(*ranges)
        end

        finish
      end

      def copy
        super
        buffer.insert = "#{self}.first"
        clear
        finish
      end

      def kill
        super
        clear
        finish
      end

      def change
        kill
        buffer.minor_mode(:control, :insert)
      end

      def wrap
        super
        finish
      end

      def comment
        refresh
        super
        refresh
      end

      def uncomment
        refresh
        super
        refresh
      end

      def evaluate!
        super
        clear
        finish
      end

      def toggle_case!
        super
        clear
        finish
      end

      def lower_case!
        super
        clear
        finish
      end
      alias downcase! lower_case!

      def upper_case!
        super
        clear
        finish
      end
      alias upcase! upper_case!

      def encode_rot13!
        super
        clear
        finish
      end

      def indent
        anchor = self.anchor.index
        insert = buffer.at_insert.index
        super
        # self.anchor.index = anchor
        # buffer.insert = insert + '1 chars'
        refresh
      end

      def unindent
        anchor = self.anchor.index
        insert = buffer.at_insert.index
        super
        # self.anchor.index = anchor
        # buffer.insert = insert + '1 chars'
        refresh
      end

      def pipe!(*cmd)
        super
        clear
        finish
      end

      # Replace every character in the selection with the character entered.
      def replace_char(char = buffer.events.last.unicode)
        replace_with_string(char, expand = true)
        buffer.minor_mode(:select_replace_char, mode_name)
      end

      # Ask for a string that every chunk of the selection should be replaced with
      def replace_string
        buffer.ask 'Replace selection with: ', do |answer, action|
          case action
          when :attempt
            if answer.size > 0
              replace_with_string(answer, expand = false)
              buffer.message "replaced #{answer.size} chars"
              :abort
            else
              buffer.warn "replacement required"
            end
          end
        end
      end

      def replace_with_clipboard
        return unless string = VER::Clipboard.string
        ranges = buffer.tag_ranges(:sel)
        from, to = ranges.first.first, ranges.last.last
        replace(from, to, string)
        finish
        buffer.mark_set :insert, from
      end

      def replace_with_string(string, expand)
        insert = buffer.index(:insert)
        anchor = self.anchor.index

        buffer.undo_record do |record|
          if expand
            each_range do |range|
              current = range.count(:displaychars)
              record.replace(*range, string * current)
            end
          else
            each_line do |y, fx, tx|
              record.replace("#{y}.#{fx}", "#{y}.#{tx}", string)
            end

            offset = (anchor.char + string.size) - 1
            buffer.insert = insert.linestart + "#{offset} chars"
          end
        end

        self.anchor.index = anchor
        refresh
      end

      # Press <Shift-F7> to work with the text as if it were one big string (multiple
      # for Ruby code that uses the variable "str".  For example, entering
      #
      # str.upcase
      #
      # will convert the selected text to uppercase.
      def string_operation
        buffer.ask 'Ruby code: ', value: 'str.' do |code, action|
          case action
          when :attempt
            begin
              string_operation!(code)
            rescue Exception => ex
              VER.warn(ex)
              buffer.warn(ex)
            else
              clear
              finish
              :abort
            end
          end
        end
      end

      # Provide a restricted scope so people cannot interfere with undo or
      # MiniBuffer.
      def string_operation!(code)
        replace(string_operation_eval(code, get))
      end

      def string_operation_eval(code, str)
        eval(code).to_str
      end

      def array_operation
        buffer.ask 'Ruby code: ', value: 'lines.' do |code, action|
          case action
          when :attempt
            begin
              array_operation!(code)
            rescue Exception => ex
              VER.error(ex)
              buffer.warn(ex)
            else
              clear
              finish
              :abort
            end
          end
        end
      end

      def array_operation!(code)
        lines = []
        first = last = nil

        each do |from_line, from_char, to_line, to_char|
          from_line.upto to_line do |lineno|
            from, to = "#{lineno}.0", "#{lineno}.0 lineend"
            first ||= from
            last = to

            line = buffer.get(from, to)
            lines << line
          end
        end

        buffer.undo_record do |record|
          modified = array_operation_eval(code, lines)
          record.replace(first, last, modified.join("\n"))
        end
      end

      # Provide a restricted scope so people cannot interfere with undo or
      # MiniBuffer.
      def array_operation_eval(code, lines)
        eval(code).to_a
      end

      # Press <F7> to iterate over each line of selected text.  You will be prompted
      # for Ruby code which will act as the body of a Ruby block which uses the
      # variable "line" and evaluates to a String.  For example:
      #
      #   line.strip.squeeze( ' ' )
      #
      # will strip off whitespace from the beginning and end of each line and then
      # collapse all consecutive sequences of spaces into single spaces.
      def line_operation
        buffer.ask 'Ruby code: ', value: 'line.' do |code, action|
          case action
          when :attempt
            begin
              line_operation!(code)
            rescue Exception => ex
              VER.error(ex)
              buffer.warn(ex)
            else
              clear
              finish
              :abort
            end
          end
        end
      end

      def line_operation!(code)
        buffer.undo_record do |record|
          each do |from_line, from_char, to_line, to_char|
            from_line.upto to_line do |lineno|
              from, to = "#{lineno}.0", "#{lineno}.0 lineend"
              line = buffer.get(from, to)
              modified = line_operation_eval(code, line)
              record.replace(from, to, modified)
            end
          end
        end
      end

      # Provide a restricted scope so people cannot interfere with undo or
      # MiniBuffer.
      def line_operation_eval(code, line)
        eval(code).to_str
      end

      def change_linestart
        first_line, last_line = first.line, last.line
        buffer.ask 'Insert text at linestart: ' do |text, action|
          case action
          when :attempt
            buffer.undo_record do |record|
              first_line.upto last_line do |line|
                record.insert("#{line}.0", text)
              end
            end
            :abort
          end
        end
      end

      def change_lineend
        first_line, last_line = first.line, last.line
        buffer.ask 'Insert text at linestart: ' do |text, action|
          case action
          when :attempt
            buffer.undo_record do |record|
              first_line.upto last_line do |line|
                record.insert("#{line}.0 lineend", text)
              end
            end
            :abort
          end
        end
      end

      def join(separator = ' ')
        buffer.undo_record do |record|
          first_line, last_line = first.line, last.line

          first_line.upto(last_line - 1) do |line|
            line = first_line

            left  = buffer.get("#{line}.0", "#{line}.0 lineend").rstrip
            right = buffer.get("#{line + 1}.0", "#{line + 1}.0 lineend").lstrip
            left << separator

            # first replace the right hand, which is the second line.
            record.replace("#{line + 1}.0", "#{line + 1}.0 lineend", right, 'sel')
            # put insert cursor at start of second line.
            buffer.insert = "#{line + 1}.0"
            # and finally join the two lines.
            record.replace("#{line}.0", "#{line}.0 lineend + 1 chars", left, 'sel')
          end
        end

        clear
        finish
      end
    end # Selection
  end # Text
end # VER
