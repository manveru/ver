module VER
  module Help
    class DescribeKey
      def initialize(parent)
        @parent = parent
        @full = []
        setup_widgets
      end

      def setup_widgets
        @label_frame = Tk::Tile::LabelFrame.new(@parent, text: 'WhichKey')
        desc = <<-DESC
Enter any key combination.
Escape closes the dialog.
Click on result opens the location of the associated method.
        DESC
        @desc = Tk::Tile::Label.new(@label_frame, text: desc).pack
        @label_frame.place relx: 0.5, rely: 0.5, anchor: :center
        @label = Tk::Tile::Label.new(@label_frame, text: 'So far:').pack
        @label.focus

        @parent.keymap.all_bound_sequences.each do |seq|
          @label.bind(seq){|event|
            if event.sequence == '<Key>'
              sequence = event.unicode
              sequence = VER::KEYSYMS.fetch(sequence, sequence)
              sequence = "<#{sequence}>" unless sequence =~ /^([a-zA-Z]|)$/
            else
              sequence = event.sequence
            end

            lookup(sequence) if sequence && !sequence.empty?
            Tk.callback_break
          }
        end

        @label.bind('<Control-q>'){ VER.exit }
        @label.bind('<Escape>'){ destroy }
      end

      def lookup(sequence)
        old_callback = @parent.keymap.callback
        @parent.keymap.callback = self

        @full << sequence
        @parent.keymap.enter_key(sequence)
      ensure
        @parent.keymap.callback = old_callback
      end

      def send(executable, *args)
        method = @parent.method(executable)
        info = <<-INFO
Sequence: #{@full.inspect}
Mapping: #{method}
Arguments: #{args.inspect}
        INFO

        @current = method
        @label.configure text: info
        @label.bind('<1>'){ open_method(method) }
        @full.clear
      end

      def inspect
        "#<VER::View::WhichKey>"
      end

      def destroy
        @label.destroy
        @label_frame.destroy
        @parent.focus
      end

      def open_method(method)
        file, line = method.source_location
        @parent.view.find_or_create(file, line)
        Tk::After.idle{ destroy }
      end
    end
  end
end
