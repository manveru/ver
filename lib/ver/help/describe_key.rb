module VER
  module Help
    class DescribeKey
      include Keymap::Results

      def initialize(parent)
        @parent = parent
        @full = []
        setup_widgets
      end

      def setup_widgets
        @label_frame = Tk::Tile::LabelFrame.new(@parent, text: 'Describe Key')
        desc = <<-DESC
Enter any key combination.
<Escape> closes this dialog.
Click on result opens the location of the associated action.
        DESC
        @desc = Tk::Tile::Label.new(@label_frame, text: desc).pack
        @label_frame.place(
          relx: 0.5,
          rely: 0.5,
          relwidth: 0.9,
          anchor: :center
        )
        @label = Tk::Tile::Label.new(@label_frame, text: 'So far:').pack
        @label.focus

        @parent.major_mode.bound_keys.each do |key|
          @label.bind(key){|event| lookup(key) }
        end

        @label.bind('<Escape>'){ @label_frame.destroy }
        @label.bind('<FocusOut>'){ @label_frame.destroy }
        @label.bind('<Destroy>'){ @parent.focus }
      end

      def lookup(pattern)
        @full << pattern

        case found = @parent.major_mode.resolve(@full)
        when Incomplete
          info = found.to_s
        when Impossible
          @full.clear
          info = found.to_s
        else
          @full.clear
          mode, action = found
          handler = action.handler || @parent.inspect
          invocation = action.invocation

          info = <<-INFO
Mode:        #{mode.name}
Handler:     #{handler}
Invocation:  #{invocation.inspect}
          INFO

          message(info){
            open_method(action.to_method(@parent))
          }
        end
      rescue => ex
        VER.error(ex)
      end

      def message(string, &action)
        @label.configure(text: string)
        @label.bind('<1>', &action)
      end

      def inspect
        "#<VER::Help::DescribeKey>"
      end

      def open_method(method)
        file, line = method.source_location
        VER.find_or_create_buffer(file, line)
        Tk::After.idle{ @label_frame.destroy }
      end
    end
  end
end
