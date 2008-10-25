module VER
  module Methods
    module Help
      include Switch

      def list_all_keys
        VER::MODES.each do |name, mode|
          list_keys_for(mode)
        end
      end

      def list_keys_for(mode = view.mode)
        window.printw("### Mode #{mode.name} ###")

        mode.each_key do |key|
          window.printw(key.inspect + "\n")
        end
      end

      def buffer_close(buffer = nil)
        view.deactivate
      end

      def buffer_open
        view.deactivate
      end

      def view_close
        view.deactivate
        View[:main].activate
      end

      SEARCH_PROC = lambda{|got|
        glob = File.join(Config[:help_dir], '*.verh')

        if got.size > 1
          choices = Dir[glob].each{|f| File.open(f){|io| io.grep(/#{got}/) } }
        else
          choices = []
        end

        if choices.size == 1
          [true, choices]
        else
          [false, choices]
        end
      }

      def help_grep
        VER.ask('Help grep: ', SEARCH_PROC) do |file|
          view.buffer = file if file
        end
      end
    end
  end
end
