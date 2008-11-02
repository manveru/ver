module VER
  module Methods
    module Buffer
      # Send a resize event to all views, this will force them to recalculate
      # their window sizes.
      # This method should be called after any resize of the terminal, and is
      # automatically issued on some terminals on the actual resize or after a
      # key was pressed.
      def window_resize
        View.resize
      end

      BUFFER_CLOSE_PROC = lambda{|got|
        options = %w[yes no cancel]
        valid = options.include?(got)
        choices = options.grep(/^#{got}/)
        [valid, choices]
      }

      def buffer_ask_about_saving(buffer = buffer)
        file = buffer.filename

        VER.ask("Save changes to: #{file}? ", BUFFER_CLOSE_PROC) do |answer|
          case answer
          when 'yes'
            buffer_persist(buffer)
            yield
          when 'no'
            yield
          when 'cancel'
          end
        end
      end

      def buffer_close(buffer = buffer)
        buffer_ask_about_saving buffer do
          if view.buffers.size > 1
            idx = view.buffers.index(buffer)
            switch_to = [0, idx, (view.buffers.size - 2)].sort[1]
            buffer.close
            view.buffers.delete(buffer)
            view.buffer = view.buffers[switch_to]
          else
            window_close
          end
        end
      end

      ASK_BUFFER_PROC = lambda{|got|
        buffer_names = View[:file].buffers.map{|b| b.filename }
        choices = buffer_names.grep(/#{got}/)
        [got, choices]
      }

      def ask_buffer
        VER.ask('Buffer: ', ASK_BUFFER_PROC) do |name|
          view.buffer = name if name
        end
      end
    end
  end
end
