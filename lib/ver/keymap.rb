module VER
  class Keymap < Struct.new(:callback, :name, :modes, :current_mode, :bindtag, :stack)
    class Mode < Struct.new(:keymap, :name, :chains, :ancestors)
      def initialize(*args)
        super
        setup
      end

      def setup
        self.chains ||= {}
        self.ancestors ||= []
      end

      def to(method_or_block, *keychains)
        keymap.register_keys(*keychains.flatten)
        keychains.each do |keychain|
          chains[keychain] = method_or_block
        end
      end

      def handle(keychain, &block)
        argument, input = extract_argument(keychain)

        ancestral_chains = [chains] + ancestors.map{|a| keymap.mode(a){|m| m.chains } }
        ancestral_chains.each do |chains|
          chains.each do |chain, cmd|
            handle_chain(input, chain, cmd, argument, &block)
          end
        end
      end

      def handle_chain(input, pattern, cmd, argument)
        if input == pattern
          yield cmd, [argument].compact
        elsif input.first == pattern.first
          pattern_head, pattern_tail = pattern[0..-2], pattern[-1]
          input_head, input_tail = input[0, pattern_head.size], input[pattern_head.size..-1]

          if pattern_head == input_head
            handle_nested_chain(pattern_tail, input_tail, cmd, argument, &Proc.new)
          else
            # no match
          end
        else
          # no match
        end
      end

      def handle_nested_chain(mode_name, input, cmd, argument)
        keymap.mode mode_name do |mode|
          mode.handle input do |command|
            keymap.callback.send cmd, [argument, command]
            keymap.stack.clear
          end
        end
      end

      def extract_argument(keychain)
        left, right = keychain.partition{|key| key =~ /^\d+$/ }

        unless left.empty?
          return left.join.to_i, right
        else
          return nil, right
        end
      end

      def uses(*names)
        self.ancestors |= names.map(&:to_sym)
      end
    end

    def initialize(*args)
      super

      self.modes ||= {}
      self.stack = []

      prepare if callback
    end

    def prepare
      0.upto(9){|n| register_key(n.to_s) }
    end

    def new(callback)
      clone.tap{|instance| instance.callback = callback }
    end

    def register_keys(*keys)
      keys.each do |key|
        register_key(key) if key.respond_to?(:to_str)
      end
    end

    def register_key(keyname)
      keyname = keyname.to_str

      case keyname
      when /^(Control-|Alt-)+(.*)/
        bindname = "#$1KeyPress-#$2"
      else
        bindname = "KeyPress-#{keyname}"
      end

      callback.bind(bindname){|key|
        try(keyname) and Tk.callback_break
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
          callback.send command, *argument
          stack.clear
        end
      end
    end

    def mode(name)
      mode = modes[name] ||= Mode.new(self, name)
      yield mode
    end
  end
end
