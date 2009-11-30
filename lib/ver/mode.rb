module VER
  class Mode
    MERGER = proc{|key, v1, v2|
      if v1.respond_to?(:merge) && v2.respond_to?(:merge)
        v1.merge(v2, &MERGER)
      else
        v2
      end
    }

    attr_accessor :callback, :name, :arguments

    def inspect
      "#<Mode #@name>"
    end

    def initialize(name, callback)
      @name, @callback = name, callback
      @stack = []
      @map = {}
      @ancestors = []
      @missing = nil
      @arguments = true
    end

    def inherits(*others)
      others.flatten.each do |other|
        ancestor = find_ancestor(other.to_sym)
        @ancestors.delete ancestor
        @ancestors.unshift ancestor
      end
    end

    def find_ancestor(name)
      if found = callback.modes[name.to_sym]
        return found
      else
        raise "Mode #{name} is not specified yet"
      end
    end

    def ancestors(*done, &block)
      yield self

      @ancestors.each do |ancestor|
        next if done.include?(ancestor)
        yield ancestor
        ancestor.ancestors(done + [self], &block)
      end
    end

    def missing(sym)
      @missing = sym
    end

    def map(sym, *keychains)
      keychains.each do |keychain|
        bind(keychain.flatten, sym)
      end
    end
    alias to map

    def bind(keychain, action_name = nil, &block)
      keychain = keychain.dup
      total = hash = {}

      while key = keychain.shift
        if key.is_a?(Symbol)
          canonical = callback.modes[key]
        else
          canonical = register(key)
        end

        if keychain.empty?
          hash[canonical] = block || action_name
        else
          hash = hash[canonical] = {}
        end
      end

      @map.replace @map.merge(total, &MERGER)
    end

    def register(key)
      callback.register(key)
    end

    def enter_keys(*keys)
      keys.flatten.each{|key| enter_key(key) }
    end

    def enter_key(key)
      @stack << key

      ancestors do |ancestor|
        result = ancestor.attempt_execute(@stack.dup)

        case result
        when nil # nothing matched yet, but possible in future
          return nil
        when false # nothing possible
          # try next one
        when true # executed
          @stack.clear
          return true
        else
          raise "%p is not a valid result" % [result]
        end
      end

      # no ancestors or all failed
      @stack.clear
      enter_missing(key)
    rescue => ex
      VER.error(ex)
      @stack.clear
    end

    def enter_missing(key)
      execute(@missing, key) if @missing
    end

    def attempt_execute(original_stack, lookup = false)
      if arguments
        stack, arg = Mode.split_stack(original_stack)
      else
        stack, arg = original_stack, nil
      end

      if stack.empty?
        arg ? nil : false
      else
        executable = @map
        while key = stack.shift
          previous = executable
          executable = executable[key]

          case executable
          when nil
            return false unless previous.respond_to?(:find)

            # FIXME: this allows only one mode
            found = previous.find{|prev_key, prev_value| prev_key.is_a?(Mode) }
            return false unless found

            mode, action = found
            looked = mode.attempt_execute([key, *stack], true)

            case looked
            when false
              return false
            when nil
              return nil
            else
              cmd, cmd_arg = looked
              return nil if cmd.is_a?(Hash)
              return execute(action, cmd, arg)
            end
          end
        end

        if lookup
          return executable, arg
        else
          execute(executable, *arg)
        end
      end
    end

    def execute(executable, *arg)
      arg = [*arg].compact # doesn't allow nil
      case executable
      when Hash
        return nil
      when Symbol
        callback.send(executable, *arg)
      when Array
        callback.send(*executable, *arg)
      when Proc
        executable.call(*arg)
      else
        return false
      end

      true
    rescue ArgumentError => ex
      callback.message("#{executable} : #{ex}")
      true
    end

    def self.split_stack(stack)
      first = stack[0]
      return stack, nil if first == '0' || first == '<KeyPress-0>'

      pivot = stack.index{|c| c !~ /^(<KeyPress-\d+>|\d+)$/ }

      if pivot == 0
        return stack, nil
      elsif pivot
        keys, args = stack[pivot..-1], stack[0..pivot]
        return keys, args.join.scan(/\d+/).join.to_i
      else
        return [], stack.join.to_i
      end
    end
  end
end
