module VER
  class Executor
    class Entry < VER::Entry
      attr_accessor :keymap, :parent, :callback
      attr_reader :mode

      def initialize(parent, options = {})
        options[:style] ||= self.class.obtain_style_name
        super
        self.parent = parent

        keymap_name = VER.options.keymap
        self.keymap = Keymap.get(name: keymap_name, receiver: self)
      end

      def setup
      end

      def destroy
        style_name = style
        super
      ensure
        self.class.return_style_name(style_name)
      end

      def mode=(name)
        @keymap.mode = @mode = name.to_sym
      end

      def tree
        callback.tree
      end

      def subset(needle, values)
        lower_needle = needle.to_s.downcase

        sorted = values.sort_by do |value|
          score = 0
          lower_value = value.downcase

          if lower_value.start_with?(lower_needle)
            score -= (needle.size + value.size)
          elsif lower_value.include?(lower_needle)
            score -= value.size
          end

          score += Levenshtein.distance(lower_needle, lower_value)
          [score, lower_value]
        end
      end

      # keymap callbacks

      def completion
        callback.completion do |entry_value|
          values = choices(entry_value)
          tree.clear

          items = values.map{|value|
            tree.insert(nil, :end, values: [*value])
          }

          return unless first = items.first

          first.focus
          first.selection_set
        end
      rescue => ex
        VER.error(ex)
      end

      def pick_selection
        callback.complete_or_pick do |value|
          if block_given?
            callback.destroy if yield(value)
          else
            catch(:invalid){
              action(value)
              callback.destroy
            }
          end
        end
      rescue => ex
        VER.error(ex)
      end

      def action(value)
        true
      end

      def speed_selection
        completion
        pick_selection
        pick_selection
        entry = callback.entry
        entry.completion if entry
      rescue => ex
        VER.error(ex)
      end

      def cancel
        callback.destroy
      end

      def line_up
        children = tree.children(nil)

        return if children.size == 1

        item = tree.focus_item.prev

        if item.id == ''
          item = children.last
        end

        item.focus
        item.see
        item.selection_set
      end

      def line_down
        children = tree.children(nil)

        return if children.size == 1

        item = tree.focus_item.next

        if item.id == ''
          item = children.first
        end

        item.focus
        item.see
        item.selection_set
      end
    end
  end
end
