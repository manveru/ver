module VER
  class Syntax
    class Processor < Struct.new(:textarea, :theme, :lineno, :stack, :tags)
      def start_parsing(syntax_name)
        self.stack = []
        self.tags = Hash.new{|h,k| h[k] = [] }
        @tag_stack = []
        tags[syntax_name] << "1.0" << "end"
      end

      def end_parsing(syntax_name)
        tags.each do |name, indices|
          tag_name = theme.get(name) || name
          textarea.tag_add(tag_name, *indices)
        end

        @tag_stack.uniq!
        @tag_stack.each_cons(2){|under, over| textarea.tag_raise(under, over) }

        stack.clear
      end

      def new_line(line)
        self.lineno += 1
      end

      def open_tag(name, pos)
        stack << [name, lineno, pos]

        if tag_name = theme.get(name)
          if stack.size > 1
            below_name = stack[-2][0]
            below = theme.get(below_name)
            return if !below || below.empty?
            @tag_stack << tag_name << below
          end
        end
      end

      def close_tag(name, mark)
        from_name, from_lineno, pos = stack.pop

        tags[name] << "#{from_lineno}.#{pos}" << "#{lineno}.#{mark}"
      rescue RuntimeError => exception
        # if you modify near the end of the textarea, sometimes the last tag
        # cannot be closed because the contents of the textarea changed since
        # the last highlight was issued.
        # this will cause Tk to raise an error that doesn't have a message and
        #  is of no major conpatterns.
        # We swallow that exception to avoid confusion.
        raise exception unless exception.message.empty?
      end
    end
  end
end
