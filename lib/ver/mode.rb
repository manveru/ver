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
      callback.modes[name.to_sym]
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
        register key

        if keychain.empty?
          hash[key] = block || action_name
        else
          hash = hash[key] = {}
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
        result = ancestor.attempt_execute(@stack)

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

    def attempt_execute(original_stack)
      if arguments
        stack, arg = Mode.split_stack(original_stack)
      else
        stack, arg = original_stack, nil
      end

      if stack.empty?
        arg ? nil : false
      else
        executable = stack.inject(@map){|keys, key| keys.fetch(key) }

        execute(executable, *arg)
      end
    rescue KeyError
      false
    end

    def execute(executable, *arg)
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
    end

    def self.split_stack(stack)
      return stack, nil if stack[0] == '0'

      pivot = stack.index{|c| c !~ /\d/ }

      if pivot == 0
        return stack, nil
      elsif pivot
        return stack[pivot..-1], stack[0..pivot].join.to_i
      else
        return [], stack.join.to_i
      end
    end
  end
end
