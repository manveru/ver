module VER
  class Keymap
    class ArbiterTag < Tk::BindTag
      attr_accessor :keymap, :widget, :receiver

      def initialize(keymap, *args)
        super(*args)
        self.keymap = keymap
        prepare_default_binds
      end

      def enter_missing(widget, key)
        keymap.modes[widget.mode].enter_missing(widget, key)
        # @history << key
        # gets_wrapper(key) || modes[mode].enter_missing(key)
      rescue => ex
        VER.error(ex)
      end

      def enter_key(widget, key)
        keymap.modes[widget.mode].enter_key(widget, key)
        # @history << key
        # gets_wrapper(key) || modes[mode].enter_key(key)
      rescue => ex
        VER.error(ex)
      end

      def execute(*args)
        receiver.send(*args)
      rescue => ex
        VER.error(ex)
      end

      def reuse(options)
        self.receiver = options.fetch(:receiver)
        self.widget = options.fetch(:widget, receiver)
        widget.mode = options.fetch(:mode, widget.mode)
        establish
        self
      end

      def establish
        tags = widget.bindtags
        p tags

        pivot = %w[Text TEntry Listbox]
        index = tags.index{|element| pivot.include?(element) }
        tags[index - 1, 0] = self

        widget.bindtags(*tags)
      end

      def prepare_default_binds
        bind '<Key>' do |event|
          widget = Tk.widgets[event.window_path]
          chunk = event.unicode
          enter_missing(widget, chunk) unless chunk == ''

          Tk.callback_break
        end

        0.upto 9 do |n|
          bind "<KeyPress-#{n}>" do |event|
            widget = Tk.widgets[event.window_path]
            enter_missing(widget, event.unicode)
            Tk.callback_break
          end
        end
      end

      def register(raw_sequence)
        case raw_sequence
        when /^[a-zA-Z]$/
          canonical = raw_sequence
        else
          canonical = raw_sequence.sub(/(Shift-|Control-|Alt-)+(?!Key)/, '\1Key-')
          canonical = "<#{canonical}>"
        end

        bind canonical do |event|
          widget = Tk.widgets[event.window_path]
          enter_key(widget, canonical)
          Tk.callback_break
        end

        return canonical
      end

      def all_bound_sequences
        sequences = Tk.execute(:bind, tag.name).to_a
        sequences.map{|seq| KEYSYMS.fetch(seq, seq) }
      end
    end # ArbiterTag
  end # Keymap
end # VER
