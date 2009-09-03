module VER
  class Keymap < Struct.new(:callback, :name, :modes, :current_mode, :bindtag, :stack)
    require 'ver/keymap/vim'

    class Mode < Struct.new(:keymap, :name, :chains, :ancestors)
      def initialize(*args)
        super
        setup
      end

      def setup
        self.chains ||= {}
        self.ancestors ||= []
      end

      def uses(*names)
        self.ancestors |= names.map(&:to_sym)
      end

      def to(method_or_block, *keychains)
        keymap.register_keys(*keychains.flatten)
        keychains.each do |keychain|
          chains[keychain] = method_or_block
        end
      end

      def handle(keychain, &block)
        argument, input = extract_argument(keychain)
        return true if input.empty?

        partial_match = false

        ancestral_chains = [chains] + ancestors.map{|a| keymap.mode(a){|m| m.chains } }
        ancestral_chains.each do |chains|
          chains.each do |chain, cmd|
            if handle_chain(input, chain, cmd, argument, &block)
              partial_match = true
            end
          end
        end

        keymap.stack.clear unless partial_match
      end

      def handle_chain(input, pattern, cmd, argument)
        if input == pattern
          yield cmd, argument
          true
        elsif input.first == pattern.first
          pattern_head, pattern_tail = pattern[0..-2], pattern[-1]
          input_head, input_tail = input[0, pattern_head.size], input[pattern_head.size..-1]

          if pattern_head == input_head
            handle_nested_chain(pattern_tail, input_tail, cmd, argument, &Proc.new)
          else
            # no match (yet?)
          end
        else
          # no match
        end
      end

      def handle_nested_chain(mode_name, input, cmd, argument)
        keymap.mode mode_name do |mode|
          mode.handle input do |command|
            keymap.stack.clear

            if argument
              return keymap.callback.send(cmd, [command, argument])
            else
              return keymap.callback.send(cmd, command)
            end
          end
        end
      end

      def extract_argument(keychain)
        return nil, keychain if keychain.first == '0'

        argument, rest = [], []
        digits = true

        keychain.each do |key|
          if digits && key =~ /^\d$/
            argument << key
          else
            digits = false
            rest << key
          end
        end

        unless argument.empty?
          return argument.join.to_i, rest
        else
          return nil, rest
        end
      end
    end

    def initialize(*args)
      super

      self.modes ||= {}
      self.stack = []

      prepare if callback
    end

    def prepare
      0.upto 9 do |n|
        callback.bind("KeyPress-#{n}"){|key|
          try(n.to_s)
          Tk.callback_break
        }
      end
    end

    def new(callback)
      clone.tap{|instance|
        instance.callback = callback
        instance.prepare
      }
    end

    def register_keys(*keys)
      keys.each do |key|
        register_key(key) if key.respond_to?(:to_str)
      end
    end

    def register_key(keyname)
      keyname = keyname.to_str

      callback.bind(keyname){|key|
        try(keyname)
        Tk.callback_break
      }
    end

    def try(key)
      stack << key
      handle(stack)
    end

    # answers with action if found,
    # nil if none matches yet,
    # false if none will ever match
    def handle(keychain)
      mode current_mode do |mode|
        mode.handle keychain do |command, argument|
          stack.clear

          if argument
            callback.send(command, argument)
          else
            callback.send(command)
          end

          return true
        end
      end
    end

    def mode(name)
      mode = modes[name] ||= Mode.new(self, name)
      yield mode
    end

    def current_mode=(cm)
      self[:current_mode] = cm
    end
  end
end
