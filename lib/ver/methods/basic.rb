module VER
  class Buffer
    # Eval the value of {Buffer} in toplevel binding.
    # So while hacking VER you can dynamically reload parts of it.
    def eval_buffer
      message "Source #{uri}"
      TOPLEVEL_BINDING.eval(value.to_s)
    end

    # Display a tooltip for the tags the insert cursor is on.
    # Also generates a status message.
    # Hides the tooltip after 5 seconds unless a seconds +count+ is given.
    def tags_tooltip(count = prefix_arg)
      index = at_insert
      value = index.tag_names.join(', ')

      message(value)
      tooltip(value, count || 5)
    end

    def tooltip(string, timeout = 5)
      require 'ver/tooltip'

      tooltip = Tk::Tooltip.new(string)
      tooltip.show_on(self)
      Tk::After.ms(timeout * 1000) { tooltip.destroy }
    end
  end

  module Methods
    module Basic
      module_function

      def minibuf_eval(buffer)
        bind = buffer.binding

        buffer.ask 'Eval: ' do |answer, action|
          case action
          when :attempt
            begin
              buffer.message(eval(answer, bind).inspect)
            rescue Exception => ex
              buffer.warn("#{ex.class}: #{ex}")
            end

            :abort
          when :complete
            EvalCompleter.complete(answer, bind)
          end
        end
      end

      def quit(text)
        text.quit
      end

      def status_evaluate(text)
        text.ask 'Eval expression: ' do |answer, action|
          case action
          when :attempt
            begin
              result = text.instance_eval(answer)
              text.message result.inspect
            rescue Exception => ex
              text.message("#{ex.class}: #{ex}")
            end
            :abort
          end
        end
      end

      def open_terminal(text)
        require_relative '../buffer/term'
        Buffer::Terminal.new(text)
      end

      def open_console(text)
        Buffer::Console.new(text)
      end
    end
  end
end
