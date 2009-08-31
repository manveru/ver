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

      def to(method_or_block, *keychains)
        keymap.register_keys(*keychains.flatten)
        keychains.each do |keychain|
          chains[keychain] = method_or_block
        end
      end

      def handle(keychain, &block)
        p name => keychain
        argument, input = extract_argument(keychain)

        partial_match = false

        ancestral_chains = [chains] + ancestors.map{|a| keymap.mode(a){|m| m.chains } }
        ancestral_chains.each do |chains|
          chains.each do |chain, cmd|
            if handle_chain(input, chain, cmd, argument, &block)
              partial_match = true
            end
          end
        end

        # FIXME: this is not nice, but well...
        p partial_match: partial_match
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
            true
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

    # names on the same line are aliases (starting from Meta)
    MODIFIERS = %w[
    Control Alt Shift Lock Extended
    Double Triple Quadruple
    Meta M
    Mod1 M1 Command
    Mod2 M2 Option
    Mod3 M3
    Mod5 M5
    Mod4 M4
    Button1 B1
    Button2 B2
    Button3 B3
    Button4 B4
    Button5 B5
    ]

    MODIFIERS_UNION = Regexp.union(MODIFIERS.map{|m| m + '-'})
    MODIFIERS_MATCH = /^(#{MODIFIERS_UNION})+(.*)/

    def register_key(keyname)
      keyname = keyname.to_str

      bindname =
        if keyname =~ MODIFIERS_MATCH
          "#$1KeyPress-#$2"
        else
          "KeyPress-#{keyname}"
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
          stack.clear

          if argument
            callback.send(command, argument)
          else
            callback.send(command)
          end

          return true
        end
      end

      false
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
