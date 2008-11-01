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

      def buffer_persist(buffer = buffer)
        filename = buffer.save_file
        VER.info "Saved to: #{filename}"
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

      # real hardcore, gotta refine that once we have multiple important views
      def window_close
        VER.stop
      end

      BUFFER_OPEN_PROC = lambda{|got|
        got = File.expand_path(got)
        got << '/' if File.directory?(got)

        choices = Dir["#{got}*"].map{|path|
          File.directory?(path) ? path + '/' : path
          path.gsub(Dir.pwd, '.')
        }

        valid = !File.directory?(got)

        [valid, choices]
      }

      def ask_file
        view = View::AskFile.new(:ask_file)
        view.open
      end

      def ask_fuzzy_file
        view = View::AskFuzzyFile.new(:ask_fuzzy_file)
        view.open
      end

      BUFFER_FIND_PROC = lambda{|got|
        buffer_names = View[:file].buffers.map{|b| b.filename }
        choices = buffer_names.grep(/#{got}/)
        [got, choices]
      }

      def buffer_select
        VER.ask('Buffer: ', BUFFER_FIND_PROC) do |name|
          view.buffer = name if name
        end
      end

      def buffer_jump(n)
        if found = view.buffers[n]
          view.buffer = found if found
        end
      end

      def resize
        View.resize
      end
    end
  end
end
