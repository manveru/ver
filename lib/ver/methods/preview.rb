module VER::Methods
  module Preview
    class << self
      def preview(text)
        return unless syntax = text.syntax

        case syntax.name
        when 'Ruby'
          open_rxvt(text, "ruby #{text.filename.shellescape}")
        end
      end

      def open_rxvt(text, command)
        frame = Tk::Frame.new(container: true)
        frame.pack(fill: :both, expand: true)
        frame.bind('<Destroy>'){ text.focus }

        cmd = "urxvt -embed #{frame.winfo_id} -e $SHELL -c %p &" % [command]
        p cmd
        `#{cmd}`
        frame.focus
      end
    end
  end
end
