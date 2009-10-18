module VER
  class Syntax
    class Processor < Struct.new(:textarea, :theme, :lineno, :stack, :tags)
      def start_parsing(syntax_name)
        self.stack = []
        self.tags = Hash.new{|h,k| h[k] = [] }
      end

      def end_parsing(syntax_name)
        tags.each do |name, indices|
          tag_name = theme.get(name) || name
          textarea.fast_tag_add(tag_name, *indices)
        end

        stack.clear
      end

      def new_line(line)
        self.lineno += 1
      end

      def tag(name, from, to)
        tags[name] << from.join('.') << to.join('.')
      end
    end
  end
end

__END__

      def open_folding(pos)
      end

      def close_folding(pos)
      end

      def open_tag(name, y, x)
        # p open_tag: [name, y, x]
        stack << [name, [y, x]]

        if tag_name = theme.get(name)
          if stack.size > 1
            below = theme.get(stack[-2][0])
            textarea.tag_raise(tag_name, below) rescue nil
          end
        end
      end

      def close_tag(name, y, x)
        # p close_tag: [name, y, x]
        sname, (sy, sx) = stack.pop

        tags[name] << "#{y}.#{x}" << "#{sy}.#{sx}"
      rescue RuntimeError => exception
        # if you modify near the end of the textarea, sometimes the last tag
        # cannot be closed because the contents of the textarea changed since
        # the last highlight was issued.
        # this will cause Tk to raise an error that doesn't have a message and
        #  is of no major consequences.
        # We swallow that exception to avoid confusion.
        raise exception unless exception.message.empty?
      end
    end
  end
end