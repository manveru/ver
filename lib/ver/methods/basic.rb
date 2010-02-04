module VER::Methods
  module Basic
    class << self
      def quit(text)
        Save.quit(text)
      end

      def source_buffer(text)
        VER.message "Source #{text.filename}"
        TOPLEVEL_BINDING.eval(text.value.to_s)
      end

      def status_evaluate(text)
        text.status_ask 'Eval expression: ' do |term|
          begin
            text.instance_eval(term)
          rescue Exception => ex
            ex
          end
        end
      end

      def tags_at(text, index = :insert)
        index = text.index(index)
        tags = text.tag_names(index)
        VER.message tags.inspect

        require 'ver/tooltip'

        tooltip = Tk::Tooltip.new(tags.inspect)
        tooltip.show_on(text)

        Tk::After.ms(5000){ tooltip.destroy }
      end

      def open_terminal(text)
        require 'ver/buffer/term'
        Buffer::Terminal.new(text)
      end

      def open_console(text)
        Buffer::Console.new(text)
      end

      def open_buffer_switch(text)
        Buffer::List::Buffer.new text do |file|
          VER.find_or_create_buffer(text, file) if File.exists?(file)
        end
      end

      def open_grep_buffer(text)
        Buffer::List::Grep.new text, filename do |file, line|
          VER.find_or_create_buffer(text, file, line)
        end
      end

      def open_grep_buffers(text)
        filenames = VER.buffers.map{|key, buffer| buffer.filename }
        glob = "{#{ filenames.join(',') }}"

        Buffer::List::Grep.new text, glob do |file, line|
          VER.find_or_create_buffer(text, file, line)
        end
      end

      def open_grep_list(text)
        Buffer::List::Grep.new text do |file, line|
          VER.find_or_create_buffer(text, file, line)
        end
      end

      def open_method_list(text)
        Buffer::List::Methods.new text do |file, line|
          VER.find_or_create_buffer(text, file, line)
        end
      end

      def open_window_switch(text, count = nil)
        if count
          # p count: count
        else
          Buffer::List::Window.new text do |buffer|
            Layout.push_top(text)
            buffer.focus
          end
        end
      end
    end
  end
end
