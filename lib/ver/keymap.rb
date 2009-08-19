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

      def resolve(keychain)
        argument, input = extract_argument(keychain)

        state = false

        ancestral_chains = [chains] + ancestors.map{|a| keymap.mode(a){|m| m.chains } }
        ancestral_chains.each do |chains|
          chains.each do |chain, cmd|
            if chain == input
              if cmd.respond_to?(:call)
                if argument && cmd.arity != 0
                  return cmd argument
                else
                  return cmd
                end
              elsif cmd
                return argument ? [cmd, argument] : cmd
              end
            elsif chain.size == input.size
              chain_tail, input_tail = chain[-1], input[-1]

              if chain_tail.is_a?(Symbol)
                keymap.mode(chain_tail){|m|
                  if found = m.resolve([input_tail])
                    return cmd, found
                  end
                }
              end

            elsif chain.size > input.size
              if chain[0, input.size] == input
                state = nil
              end
            end
          end
        end

        return state
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
      setup
    end

    def setup
      self.modes ||= {}
      self.stack = []
    end

    def new(callback)
      clone.tap{|instance| instance.callback = callback }
    end

    def register_keys(*keys)
      keys.each do |key|
        register_key(key)
      end
    end

    def register_key(keyname)
      return unless keyname.respond_to?(:to_str)

      callback.bind(keyname.to_str){|key|
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
    def resolve(keychain)
      mode current_mode do |mode|
        case result = mode.resolve(keychain)
        when nil # wait for more
          p 'wait for more'
          return mode, nil
        when false # fail
          return mode, false, keychain
        else
          return mode, *result
        end
      end
    end

    def handle(keychain)
      mode, handler, args = resolve(keychain)

      case handler
      when nil # wait for more
        true
      when false # fail and abort
        stack.clear
        false
      else
        p handler: handler, args: args
        callback.send(handler, *args)
        stack.clear
        true
      end
    end

    def event(name, arg = nil)
      p :event => [name, arg]
    end

    def mode(name)
      mode = modes[name] ||= Mode.new(self, name)
      yield mode
    end
  end
end
