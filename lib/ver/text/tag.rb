module VER
  class Text
    # The first form of annotation in text widgets is a tag.
    # A tag is a textual string that is associated with some of the characters
    # in a text.
    # Tags may contain arbitrary characters, but it is probably best to avoid
    # using the characters " " (space), "+" (plus), or "-" (minus): these
    # characters have special meaning in indices, so tags containing them cannot
    # be used as indices.
    # There may be any number of tags associated with characters in a text.
    # Each tag may refer to a single character, a range of characters, or
    # several ranges of characters.
    # An individual character may have any number of tags associated with it.
    #
    # A priority order is defined among tags, and this order is used in
    # implementing some of the tag-related functions described below.
    # When a tag is defined (by associating it with characters or setting its
    # display options or binding commands to it), it is given a priority higher
    # than any existing tag.
    # The priority order of tags may be redefined using the "pathName tag
    # raise" and "pathName tag lower" widget commands.
    #
    # Tags serve three purposes in text widgets.
    # First, they control the way information is displayed on the screen.
    # By default, characters are displayed as determined by the -background,
    # -font, and -foreground options for the text widget.
    # However, display options may be associated with individual tags using the
    # "pathName tag configur" widget command.
    # If a character has been tagged, then the display options associated with
    # the tag override the default display style.
    class Tag < Struct.new(:buffer, :name)
      # FIXME: yes, i know i'm calling `tag add` for every line, which makes
      #        things slower, but it seems like there is a bug in the text widget.
      #        So we aggregate the information into a single eval.
      def add(*indices)
        code = [%(set win "#{buffer.tk_pathname}")]

        indices.each_slice(2) do |first, last|
          if last
            code << %($win tag add #{name} "#{first}" "#{last}")
          else
            code << %($win tag add #{name} "#{first}")
          end
        end

        Tk.execute_only(Tk::TclString.new(code.join("\n")))
      end

      def bind(*args, &block)
        buffer.tag_bind(to_tcl, *args, &block)
      end

      def cget(option)
        buffer.tag_cget(self, option)
      end

      # Comment all lines that the selection touches.
      # Tries to maintain indent.
      def comment
        comment = buffer.options.comment_line.to_s
        indent = nil
        lines = []

        each_line do |line, fc, tc|
          line_fc, line_tc = "#{line}.#{fc}", "#{line}.#{tc}"

          next if buffer.at_end == line_tc

          lines << line

          next if indent == 0 # can't get lower

          line = buffer.get("#{line}.#{fc}", "#{line}.#{tc}")

          next unless start = line =~ /\S/

          indent ||= start
          indent = start if start < indent
        end

        indent ||= 0

        buffer.undo_record do |record|
          lines.each do |line|
            record.insert("#{line}.#{indent}", comment)
          end
        end
      end

      def configure(*options)
        buffer.tag_configure(self, *options)
      end

      def copy
        chunks = ranges.map{|range| range.get }
        buffer.with_register{|reg| reg.value = chunks.at(1) ? chunks : chunks.first }
      end

      def delete
        buffer.tag_delete(self)
      end
      alias tag_delete delete

      def each_range(&block)
        ranges.each(&block)
      end

      def each_line
        return Enumerator.new(self, :each_line) unless block_given?

        each_range do |range|
          fy, fx, ty, tx = *range.first, *range.last
          fy.upto(ty) do |y|
            yield y, fx, tx
          end
        end
      end

      def encode_rot13!
        buffer.undo_record do |record|
          each_range do |range|
            range.encode_rot13!(record)
          end
        end
      end

      # Eval contents of tag and insert them into the buffer.
      def evaluate!
        file = buffer.filename

        each_range do |range|
          code = range.get

          Methods::Control.stdout_capture_evaluate(code, file, binding) do |res, out|
            range.last.lineend.insert("\n%s%p" % [out, res])
          end
        end
      end

      def first
        buffer.index("#{self}.first")
      end

      def get
        values = ranges.map{|range| range.get }
        values.size == 1 ? values.first : values unless values.empty?
      end

      def indent
        indent_size = buffer.options.shiftwidth
        indent = ' ' * indent_size

        buffer.undo_record do |record|
          each_line do |y, fx, tx|
            tx = fx + indent_size
            next if buffer.get("#{y}.#{fx}", "#{y}.#{tx}").empty?
            record.insert("#{y}.#{fx}", indent)
          end
        end
      end

      def inspect
        "#<VER::Text::Tag %p on %p>" % [name, buffer]
      end

      def kill
        indices = []

        chunks = ranges.map{|range|
          indices << range.first << range.last
          range.get
        }

        # A bit of duplication, but if we use copy here we have to iterate the
        # ranges again.
        buffer.with_register do |register|
          register.value = chunks.at(1) ? chunks : chunks.first
        end

        buffer.delete(*indices)
      end

      def last
        buffer.index("#{self}.last")
      end

      def lower(below_this = Tk::None)
        buffer.tag_lower(self, below_this)
      end
      alias tag_lower lower

      # Convert all characters within the tag to lower-case using
      # String#downcase.
      # Usually only works for alphabetic ASCII characters.
      def lower_case!
        buffer.undo_record do |record|
          each_range do |range|
            range.lower_case!(record)
          end
        end
      end
      alias downcase! lower_case!

      def next_range(from_index, to_index = Tk::None)
        buffer.tag_nextrange(self, from_index, to_index)
      end
      alias nextrange next_range

      # Replace contents of tag with stdout output of a command
      def pipe!(*cmd)
        require 'open3'

        Open3.popen3(*cmd) do |si, so, thread|
          queue = []
          each_range do |range|
            si.write(range.get)
            queue.concat(range.to_a)
          end

          si.close
          output = so.read

          return if queue.empty?

          buffer.undo_record do |record|
            record.delete(*queue)
            record.insert(queue.first, output.chomp)
          end
        end
      end

      def prev_range(from_index, to_index = Tk::None)
        buffer.tag_prevrange(self, from_index, to_index)
      end
      alias prevrange prev_range

      def raise(above_this = Tk::None)
        buffer.tag_raise(above_this)
      end
      alias tag_raise raise

      def ranges
        buffer.tag_ranges(self)
      end

      def remove(index, *indices)
        buffer.tag_remove(self, index, *indices)
      end
      alias tag_remove remove

      def replace(*args)
        buffer.range("#{self}.first", "#{self}.last").replace(*args)
      end

      def to_s
        name.to_s
      end

      def to_tcl
        name.to_tcl
      end

      # Toggle case within the selection.
      # This only works for alphabetic ASCII characters, no other encodings.
      def toggle_case!
        buffer.undo_record do |record|
          each_range do |range|
            range.toggle_case!(record)
          end
        end
      end

      def uncomment
        comment = buffer.options.comment_line.to_s
        regex = /#{Regexp.escape(comment)}/

        buffer.undo_record do |record|
          each_line do |y, fx, tx|
            from, to = "#{y}.0 linestart", "#{y}.0 lineend"
            line = buffer.get(from, to)

            if line.sub!(regex, '')
              record.replace(from, to, line)
            end
          end
        end
      end

      def unindent
        indent_size = buffer.options.shiftwidth
        indent = ' ' * indent_size
        queue = []

        each_line do |y, fx, tx|
          tx = fx + indent_size
          left, right = "#{y}.#{fx}", "#{y}.#{tx}"
          next unless buffer.get(left, right) == indent
          queue << left << right
        end

        buffer.delete(*queue)
      end

      # Convert all characters within the tag to upper-case using
      # String#upcase.
      # Usually only works for alphabetic ASCII characters.
      def upper_case!
        buffer.undo_record do |record|
          each_range do |range|
            range.upper_case!(record)
          end
        end
      end
      alias upcase! upper_case!

      def wrap(width = buffer.prefix_count(80))
        wrapped = Methods::Control.wrap_lines_of(get, width)
        replace(wrapped.join("\n"))
      end
    end
  end
end
