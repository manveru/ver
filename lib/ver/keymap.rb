module VER
  class Keymap < Struct.new(:callback, :name, :modes, :current_mode, :tag, :stack, :original_tags)
    require 'ver/keymap/vim'

    class Mode < Struct.new(:keymap, :name, :chains, :ancestors, :tag)
      def initialize(*args)
        super
        setup
      end

      def setup
        self.chains ||= {}
        self.ancestors ||= []
        self.tag = TkBindTag.new

        0.upto 9 do |n|
          tag.bind("KeyPress-#{n}"){|key|
            keymap.try(n.to_s)
            Tk.callback_break
          }
        end
      end

      def uses(*names)
        self.ancestors |= names.map(&:to_sym)
      end

      def to(method_or_block, *keychains)
        register_keys(*keychains.flatten)

        keychains.each do |keychain|
          chains[keychain] = method_or_block
        end
      end

      def missing(receiver)
        tag.bind('Key'){|key|
          keymap.callback.send(receiver, key.char)
          Tk.callback_break
        }
      end

      def register_keys(*keys)
        keys.each do |key|
          register_key(key) if key.respond_to?(:to_str)
        end
      end

      def register_key(keyname)
        keyname = keyname.to_str

        tag.bind(keyname){|key|
          keymap.try(keyname) and Tk.callback_break
        }
      end

      def handle(keychain, &block)
        input, argument = extract_argument(keychain)
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
            true
            # no match (yet?)
          end
        else
          # true
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
        return keychain, [] if keychain.first == '0'

        index = keychain.index{|o| o !~ /\d/ }
        return [], [] unless index
        head = keychain[0...index]

        argument = head.join.to_i unless head.empty?

        return keychain[index..-1], argument
      end

      def ancestral_tags
        ([tag] + ancestors.map{|a| keymap.mode(a){|m| m.tag }}).reverse
      end
    end

    def initialize(*args)
      super

      self.modes ||= {}
      self.stack = []
      self.tag = TkBindTag.new

      prepare if callback
    end

    def new(callback)
      clone.tap{|instance|
        instance.callback = callback
        instance.prepare
      }
    end

    def prepare
      self.original_tags = callback.bindtags.dup
    end

    def assign_current_mode_tags
      tags = original_tags.dup

      current_mode_tags = collect_current_mode_tags
      tags[tags.index(callback) + 1, 0] = current_mode_tags
      tags.delete Tk::Text

      callback.bindtags = tags
    end

    def collect_current_mode_tags
      mode current_mode do |mode|
        return mode.ancestral_tags
      end
    end

    def try(key)
      stack << key
      handle(stack)
    end

    def handle(keychain)
      mode current_mode do |mode|
        mode.handle keychain do |command, argument|
          stack.clear

          if argument
            p callback: [command, argument]
            callback.send(command, *argument)
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
      assign_current_mode_tags
    end
  end
end
