require 'set'

module VER
  class Keymap < Struct.new(:keymap, :keys)
    module Platform
      def x11?
        windowingsystem == :x11
      end

      def win32?
        windowingsystem == :win32
      end

      def aqua?
        windowingsystem == :aqua
      end

      def windowingsystem
        @windowingsystem ||= Tk::TkCmd.windowingsystem
      end

      def bsd?
        FFI::Platform.bsd?
      end

      def windows?
        FFI::Platform.windows?
      end

      def mac?
        FFI::Platform.mac?
      end

      def unix?
        FFI::Platform.unix?
      end

      def operatingsystem
        FFI::Platform::OS
      end
    end

    module Results
      # Indicate that no result can and will be found in the keymap
      class Impossible < Struct.new(:pattern)
        def to_s
          stack = pattern.map{|seq| Event[seq].keysym }.join(' - ')
          "#{stack} is undefined"
        end
      end

      # Indicate that no result could be found yet.
      class Incomplete < Struct.new(:pattern, :choices)
        def merge!(incomplete)
          return unless pattern == incomplete.pattern
          choices.deep_merge!(incomplete.choices)
        end

        def to_s(handler)
          stack = pattern.map{|seq| Event[seq].keysym }.join

          follow = choices.map{|key, action|
            case action
            when Action
              method = action.to_method(handler)
              args = [*action.invocation][1..-1]

              case receiver = method.receiver
              when Class, Module
                signature = "#{receiver}.#{method.name}"
              else
                signature = "#{method.receiver.class}.#{method.name}"
              end

              unless args.empty?
                signature << '(' << args.map(&:inspect).join(', ') << ')'
              end

              "#{key} => #{signature}"
            when MapHash
              key
            else
              '%s => %p' % [key, action]
            end
          }.join(', ')
          "#{stack} -- (#{follow})"
        end
      end
    end

    include Results

    # A subclass to make lookup unambigous
    class MapHash < Hash
      def deep_each(&block)
        if block
          each do |key, value|
            if value.respond_to?(:deep_each)
              value.deep_each(&block)
            else
              yield key, value
            end
          end
        else
          Enumerator.new(self, :deep_each)
        end
      end

      def deep_merge!(other)
        replace(merge(other, &MERGER))
      end

      def deep_merge(other)
        merge(other, &MERGER)
      end
    end

    MERGER = proc{|key, v1, v2|
      if v1.respond_to?(:merge) && v2.respond_to?(:merge)
        v1.merge(v2, &MERGER)
      else
        v2
      end
    }

    def initialize(keymap = MapHash.new, keys = Set.new)
      self.keymap = keymap
      self.keys = keys
    end

    def []=(*pattern, action)
      pattern = pattern_to_patterns(*pattern)
      top = sub = MapHash.new

      while key = pattern.shift
        self.keys << key if key.respond_to?(:keysym)

        if pattern.empty?
          sub[key] = action
        else
          sub = sub[key] = MapHash.new
        end
      end

      keymap.replace(keymap.merge(top, &MERGER))
    end

    def [](*pattern)
      pattern = [*pattern].flatten
      remaining = pattern.dup

      current = keymap
      while key = remaining.shift
        previous = current

        if current.key?(key)
          current = current[key]
          break unless current.respond_to?(:key?)
        else
          current.find do |ckey, cvalue|
            next unless ckey.is_a?(Symbol)

            case resolved = MinorMode[ckey].resolve([key, *remaining])
            when Incomplete
              return resolved
            when Impossible
              false
            else
              return cvalue.combine(resolved.last)
            end
          end

          return Impossible.new(pattern)
        end
      end

      case current
      when MapHash # incomplete
        Incomplete.new(pattern, current)
      else
        current
      end
    end

    def merge(keymap)
      merged = keymap.keymap.merge(self.keymap, &MERGER)
      self.class.new(merged, keys + keymap.keys)
    end

    def merge!(keymap)
      self.keymap = keymap.keymap.merge(self.keymap, &MERGER)
      self.keys += keymap.keys
      keymap
    end

    def actions
      keymap.deep_each.map{|key, value| value }
    end

    def pattern_to_patterns(*patterns)
      result = []

      patterns.flatten.each do |pattern|
        if pattern.respond_to?(:scan)
          pattern.scan(/<<[^>]+>>|<[^>]+>|(?!\s<)[[:print:]]/) do
            result << Event[$&].pattern
          end
        else
          result << pattern
        end
      end

      result
    end
  end
end
