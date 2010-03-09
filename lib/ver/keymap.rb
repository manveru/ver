require 'set'

module VER
  class Keymap < Struct.new(:keymap, :keys)
    module Results
      # Indicate that no result can and will be found in the keymap
      class Impossible < Struct.new(:sequence)
        def to_s
          stack = sequence.map{|seq| Event[seq].keysym }.join(' - ')
          "#{stack} is undefined"
        end
      end

      # Indicate that no result could be found yet.
      class Incomplete < Struct.new(:sequence, :choices)
        def merge!(incomplete)
          return unless sequence == incomplete.sequence
          choices.deep_merge!(incomplete.choices)
        end

        def to_s(handler)
          stack = sequence.map{|seq| Event[seq].keysym }.join

          follow = choices.map{|key, action|
            case action
            when Action
              method = action.to_method(handler)
              args = [*action.invocation][1..-1]
              signature = "#{method.receiver}.#{method.name}"

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

    def []=(*sequence, action)
      sequence = [*sequence].flatten
      top = sub = MapHash.new

      while key = sequence.shift
        if key.respond_to?(:to_str)
          canonical = Event[key.to_str].sequence
          self.keys << canonical
        else
          canonical = key
        end

        if sequence.empty?
          sub[canonical] = action
        else
          sub = sub[canonical] = MapHash.new
        end
      end

      keymap.replace(keymap.merge(top, &MERGER))
    end

    def [](*sequence)
      sequence = [*sequence].flatten
      remaining = sequence.dup

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

          return Impossible.new(sequence)
        end
      end

      case current
      when MapHash # incomplete
        Incomplete.new(sequence, current)
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

    def key_to_canonical(key)
      case key
      when /^[a-zA-Z0-9]$/
        key
      when /^</
        key
      else
        "<#{key}>"
      end
    end
  end
end
