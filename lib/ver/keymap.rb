require 'set'

module VER
  class Keymap < Struct.new(:keymap, :keys)
    # A subclass to make lookup unambigous
    class MapHash < Hash; end

    # Indicate that no result can and will be found in the keymap
    class Impossible; end
    IMPOSSIBLE = Impossible.new

    # Indicate that no result could be found yet.
    class Incomplete; end
    INCOMPLETE = Incomplete.new

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
          canonical = key_to_canonical(key.to_str)
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

      current = keymap
      while key = sequence.shift
        previous = current

        if current.key?(key)
          current = current[key]
          break unless current.respond_to?(:key?)
        else
          found = nil
          current.find do |ckey, cvalue|
            next unless ckey.is_a?(Symbol)

            case resolved = MinorMode[ckey].resolve([key, *sequence])
            when INCOMPLETE
              return found
            when IMPOSSIBLE
              false
            else
              return cvalue.combine(resolved)
            end
          end

          return IMPOSSIBLE
        end
      end

      case current
      when MapHash # incomplete
        INCOMPLETE
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
