require 'bacon'
Bacon.summary_on_exit

module VER
  class Keyboard
  end

  class Keymap
    attr_accessor :modes, :current_mode

    def initialize
      @modes = {}
    end

    def send(*args)
      @callback.__send__(*args)
    end

    def enter_key(key)
      modes[current_mode].enter_key key
    end

    # TODO: callbacks
    def current_mode=(cm)
      @current_mode = cm.to_sym
    end

    def add_mode(name)
      @modes[name.to_sym] = mode = Mode.new(self)
      yield mode if block_given?
      mode
    end
  end

  class Mode
    def initialize(callback = nil)
      @callback = callback
      @stack = []
      @map = {}
      @ancestors = []
    end

    def inherit(other)
      @ancestors.delete other
      @ancestors.unshift other
    end

    def ancestors(&block)
      ([self] + @ancestors).find(&block)
    end

    def map(sym, *keychain)
      bind(*keychain.flatten){|*arg| @callback.send(sym, *arg) }
    end

    def bind(*keychain, &block)
      keychain = keychain.dup
      total = hash = {}

      while key = keychain.shift
        if keychain.empty?
          hash[key] = block
        else
          hash = hash[key] = {}
        end
      end

      @map.replace @map.merge(total, &MERGER)
    end

    def enter_keys(*keys)
      keys.flatten.each{|key| enter_key(key) }
    end

    def enter_key(key)
      @stack << key
      ancestors{|ancestor| ancestor.attempt_execute(@stack) }
    end

    def attempt_execute(original_stack)
      stack, arg = Mode.split_stack(original_stack)
      return false if stack.empty?

      executable = stack.inject(@map){|keys, key| keys.fetch(key) }

      if execute(executable, *arg)
        original_stack.clear
        return true
      end

      false
    rescue KeyError
      false
    end

    def execute(executable, *arg)
      case executable
      when Proc
        executable.call(*arg)
        true
      when Symbol
        @callback.send(executable, *arg)
      else
        false
      end
    end

    def self.split_stack(stack)
      return stack, nil if stack[0] == '0'

      pivot = stack.index{|c| c !~ /\d/ }

      if pivot == 0
        return stack, nil
      elsif pivot
        return stack[pivot..-1], stack[0..pivot].join.to_i
      else
        return [], nil
      end
    end

    MERGER = proc{|key,v1,v2|
      Hash === v1 && Hash === v2 ? v1.merge(v2, &MERGER) : v2
    }
  end
end

describe Mode = VER::Mode do
  it 'splits stack into argument and keychain' do
    Mode.split_stack(['4', 'a']).should == [['a'], 4]
    Mode.split_stack(['4', '2', 'a']).should == [['a'], 42]
    Mode.split_stack(['4', '2', 'a', 'b']).should == [['a', 'b'], 42]
    Mode.split_stack(['a', 'b']).should == [['a', 'b'], nil]
  end

  it 'executes action assigned to key' do
    done = false
    mode = Mode.new
    mode.bind('a'){ done = true }
    mode.enter_keys 'a'
    done.should == true
  end

  it 'executes action assigned to key chain (immediately)' do
    done = false
    mode = Mode.new
    mode.bind('a', 'b', 'c'){ done = true }
    mode.enter_keys 'a', 'b', 'c'
    done.should == true
  end

  it 'executes action assigned to key chain (delayed)' do
    done = false
    mode = Mode.new
    mode.bind('a', 'b', 'c'){ done = true }
    mode.enter_key 'a'
    mode.enter_key 'b'
    mode.enter_key 'c'
    done.should == true
  end

  it 'executes action with numeric argument' do
    done = false
    mode = Mode.new
    mode.bind('a', 'b', 'c'){|arg| done = arg }
    mode.enter_keys '4', '2', 'a', 'b', 'c'
    done.should == 42
  end

  it 'executes action on callback' do
    done = false
    callback = Class.new{
      attr_accessor :done

      def foo
        @done = true
      end
    }.new

    mode = Mode.new(callback)
    mode.map :foo, %w[a b c]
    mode.enter_keys %w[a b c]
    callback.done.should == true
  end

  it 'inherits another mode but executes actions itself' do
    first_done = second_done = false
    first, second = Mode.new, Mode.new
    second.inherit(first)
    second.bind('a', 'b', 'c'){|arg| second_done = arg }
    second.enter_keys %w[4 2 a b c]
    second_done.should == 42
  end

  it 'inherits another mode that also executes actions' do
    first_done = second_done = false
    first, second = Mode.new, Mode.new
    second.inherit(first)

    first.bind('first-key'){|arg| first_done = arg }
    second.bind('second-key'){|arg| second_done = arg }

    second.enter_keys %w[4 2 first-key]
    first_done.should == 42

    second.enter_keys %w[2 4 second-key]
    second_done.should == 24
  end
end

describe Keymap = VER::Keymap do
  it 'adds a mode into the keymap' do
    done = false

    keymap = Keymap.new
    keymap.add_mode :test do |mode|
      mode.bind('a'){ done = true }
    end
    keymap.current_mode = :test

    keymap.enter_key 'a'
    done.should == true
  end
end
