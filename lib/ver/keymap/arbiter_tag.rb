module VER
  class Keymap
    class ArbiterTag < Tk::BindTag
      attr_accessor :keymap

      def initialize(keymap, *args)
        super(*args)
        self.keymap = keymap
        prepare_default_binds
      end

      def enter_missing(widget, key)
        widget.keymap.enter_missing(widget, key)
      rescue => ex
        VER.error(ex)
      end

      def enter_key(widget, key)
        widget.keymap.enter_key(widget, key)
      rescue => ex
        VER.error(ex)
      end

      def reuse(options)
        widget = options.fetch(:widget)
        widget.mode = options.fetch(:mode, widget.mode)
        establish(widget)
        self
      end

      def establish(widget)
        tags = widget.bindtags

        pivot = %w[Text TEntry Listbox]
        index = tags.index{|element| pivot.include?(element) }
        tags[index - 1, 0] = self

        widget.bindtags(*tags)
      end

      def prepare_default_binds
        bind '<Key>' do |event|
          chunk = event.unicode

          unless chunk == ''
            widget = Tk.widgets[event.window_path]
            enter_missing(widget, chunk)
          end

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
        canonical = raw_sequence_to_canonical(raw_sequence)

        bind canonical do |event|
          widget = Tk.widgets[event.window_path]
          enter_key(widget, canonical)
          Tk.callback_break
        end

        return canonical
      end

      def raw_sequence_to_canonical(raw)
        case raw
        when /^[a-zA-Z]$/
          raw
        else
          canonical = raw.sub(/(Shift-)+(?!Key)/, '\1Key-')
          "<#{canonical}>"
        end
      end

      def all_bound_sequences
        sequences = Tk.execute(:bind, tag.name).to_a
        sequences.map{|seq| KEYSYMS.fetch(seq, seq) }
      end
    end # ArbiterTag
  end # Keymap
end # VER
