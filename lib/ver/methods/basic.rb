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
            eval(term)
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
        require 'ver/view/term'
        View::Terminal.new(text)
      end

      def open_console(text)
        View::Console.new(text)
      end

      def open_buffer_switch(text)
        View::List::Buffer.new text do |file|
          Views.find_or_create(text, file) if File.exists?(file)
        end
      end

      def open_grep_buffer(text)
        View::List::Grep.new text, filename do |file, line|
          Views.find_or_create(text, file, line)
        end
      end

      def open_grep_buffers(text)
        filenames = text.layout.views.map{|v| v.text.filename }
        glob = "{#{ filenames.join(',') }}"

        View::List::Grep.new text, glob do |file, line|
          Views.find_or_create(text, file, line)
        end
      end

      def open_grep_list(text)
        View::List::Grep.new text do |file, line|
          Views.find_or_create(text, file, line)
        end
      end

      def open_method_list(text)
        View::List::Methods.new text do |file, line|
          Views.find_or_create(text, file, line)
        end
      end

      def open_window_switch(text, count = nil)
        if count
          # p count: count
        else
          View::List::Window.new text do |view|
            Views.push_top(text)
            view.focus
          end
        end
      end
    end
  end
end
