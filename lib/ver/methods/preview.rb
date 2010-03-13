module VER
  module Methods
    module Preview
      class Frame < Tk::Frame
        def shown?
          true
        end

        def hidden?
          false
        end
      end

      module_function

      def preview(buffer)
        return unless syntax = buffer.syntax

        method = "preview_#{syntax.name}".downcase

        if respond_to?(method)
          send(method, buffer)
        end
      end

      def compile(buffer)
        return unless syntax = buffer.syntax

        method = "compile_#{syntax.name}".downcase

        if respond_to?(method)
          send(method, buffer)
        end
      end

      def compile_haml(buffer)
      end

      def compile_sass(buffer)
      end

      def preview_ruby(buffer)
        buffer.save
        spawn_rxvt(<<-SHELL)
ruby #{buffer.filename.shellescape}
echo "\nPreview finished, press <Return> to return to VER"
read
exit
        SHELL
      end

      # Open a new urxvt term in the background, this is not kept inside VER
      # layout.
      def spawn_rxvt(command)
        system("urxvt -e $SHELL -c '%s' &" % [command])
      end

      # Open a new urxvt term and manage it inside the layout of VER.
      # Please let me know if you notice weird behaviour around the focus
      def open_rxvt(buffer, command)
        layout = buffer.layout

        # No Tk::Tile::Frame as it doesn't support container
        frame = Frame.new(layout, container: true)
        layout.add_buffer(frame)

        frame.bind '<MapRequest>' do |event|
          # Quite the weird hack, but once the MapRequest was handled, we can
          # focus the frame again to actually focus the term.
          # The delay was chosen by trying it on my notebook, which may or may
          # not be enough for everybody, so i added a bit of margin for error.
          # Usually humans don't notice the delay, so we could increase it a bit
          # if need arises.
          Tk::After.ms 100 do
            buffer.focus
            frame.focus
          end
        end

        frame.bind '<Map>' do |event|
          cmd = "urxvt -embed #{frame.winfo_id} -e $SHELL -c '%s' &" % [command]
          # puts cmd
          `#{cmd}`
        end

        frame.bind '<Destroy>' do |event|
          Tk::After.idle do
            layout.close_buffer(frame)
            buffer.focus(:force) # need to use force, the term was outside tk
          end
        end
      end
    end
  end
end
