module VER
  class Buffer
    class Frame < Tk::Frame
      attr_reader :buffer
      attr_accessor :shown
      alias shown? shown

      def initialize(parent, buffer, options = {})
        @buffer = buffer
        options = options.dup
        # options[:style] ||= VER.obtain_style_name('Buffer', 'TFrame')
        # options[:padding] ||= 2
        # options[:relief] ||= :solid
        super(parent, options)

        @shown = true

        bind('<FocusIn>'){ buffer.focus; Tk.callback_break }
      end
    end
  end
end
