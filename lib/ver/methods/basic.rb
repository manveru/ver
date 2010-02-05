module VER
  module Methods
    module Basic
      module_function

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
    end
  end
end
