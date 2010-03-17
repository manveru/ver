module VER
  module ModeResolving
    include Keymap::Results

    # recursively try to find the pattern in the major mode and its parent
    # modes.
    def resolve(pattern, parents)
      keymap_result = keymap[pattern]

      case keymap_result
      when Incomplete # try to find a full or longer match in parents
        resolve_incomplete(pattern, parents, keymap_result)
      when Impossible # anything better than that.
        resolve_impossible(pattern, parents, keymap_result)
      else
        # full match from us, so get the action out.
        return keymap_result
      end
    end

    def resolve_incomplete(pattern, parents, result)
      parents.each do |parent|
        next if parent == self

        parent_result = parent.resolve(pattern)

        case parent_result
        when Incomplete # merge and see if there's something better
          result.merge!(parent_result)
        when Impossible # even worse than us, skip
        when Fallback # no match, we are incomplete already
        else # full match, yay!
          return parent_result
        end
      end

      return result
    end

    def resolve_impossible(pattern, parents, result)
      incomplete = nil
      fallback = nil

      parents.each do |parent|
        next if parent == self

        parent_result = parent.resolve(pattern)

        case parent_result
        when Incomplete # better than us, keep it for later
          if incomplete
            incomplete.merge!(parent_result)
          else
            incomplete = parent_result
          end
        when Impossible # just as bad, ignore
        when Fallback # better than us, keep for later
          fallback ||= parent_result
        else
          # full match, whaoh!
          return parent_result
        end
      end

      return incomplete if incomplete
      return fallback_action if fallback_action
      return fallback if fallback
      return result
    end
  end
end
