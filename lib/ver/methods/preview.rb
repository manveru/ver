module VER::Methods
  module Preview
    class << self
      def preview(text)
        return unless syntax = text.syntax

        case syntax.name
        when 'Ruby'
          open_rxvt(text, <<-SHELL)
ruby #{text.filename.shellescape}
echo "\nPreview finished, press <Return> to return to VER"
read
          SHELL
        end
      end

      # Open a new urxvt term and manage it inside the layout of VER.
      # Please let me know if you notice weird behaviour around the focus
      def open_rxvt(text, command)
        layout = text.layout

        # No Tk::Tile::Frame as it doesn't support container
        frame = Tk::Frame.new(layout, container: true)
        layout.add_buffer(frame)

        frame.bind '<MapRequest>' do |event|
          # Quite the weird hack, but once the MapRequest was handled, we can
          # focus the frame again to actually focus the term.
          # The delay was chosen by trying it on my notebook, which may or may
          # not be enough for everybody, so i added a bit of margin for error.
          # Usually humans don't notice the delay, so we could increase it a bit
          # if need arises.
          Tk::After.ms 100 do
            text.focus
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
            text.focus(:force) # need to use force, the term was outside tk
          end
        end
      end
    end
  end
end
