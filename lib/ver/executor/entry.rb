module VER
  class Executor
    # This class defines the opening dialog used in ExPath, ExTheme and so on.
    # There are a bunch of callbacks you can use to define your own, namely
    # #action, #after_update, #choices, #completed=, #update_items
    # @example a simple one
    #    @see ExPath
    # @example rather complex
    #    @see ExFuzzyFileFinder
    class Entry < VER::Entry
      include Keymapped

      attr_accessor :parent, :callback, :update_on_change, :tabcount
      attr_reader :caller, :tree, :ybar

      def initialize(parent, options = {})
        @callback = options.delete(:callback)
        @caller   = @callback.caller
        @tree     = @callback.tree
        @ybar     = @callback.ybar

        mode = options.delete(:mode)
        options[:style] ||= VER.obtain_style_name('ExEntry', 'TEntry')

        super

        self.parent = parent
        self.major_mode = :Executor
        self.minor_mode(:executor_label, mode) if mode

        self.tabcount = 0
        self.update_on_change = true

        bind('<<Inserted>>', &method(:on_insert))
        bind('<<Deleted>>', &method(:on_delete))
      end

      # Called on <<Inserted>> events.
      def on_insert(event)
        self.tabcount = 0
        update_only if update_on_change
      end

      # Called on <<Deleted>> events.
      def on_delete(event)
        self.tabcount = 0
        update_only if update_on_change
      end

      # @param [Array<Object>] values the items to be inserted into the tree
      # @return [Array<Item>] inserted items
      def update_items(values)
        values.map{|value|
          tree.insert(nil, :end, values: [*value])
        }
      end

      # @param [String] entered entered string value in the text field
      # @return [Array|Array<Array>] passed to #update_items
      # @abstract
      def choices(entered)
      end

      def update_only
        values = choices(value)
        tree.clear

        items = update_items(values)

        return unless first = items.first

        first.focus
        first.selection_set

        after_update
      end

      # Called after the other widgets are set up.
      # @abstract
      # @return [void]
      def setup
      end

      # Not sure wherever that's called at all...
      def completed=(values)
        self.value = values.first
      end

      def destroy
        style_name = style
        super
      ensure
        VER.return_style_name(style_name)
      end

      # create a subset of the given +values+, filtered and sorted by checking
      # relevance against the given +needle+.
      # If +values+ is an Array of arrays, we only use the first entry of each
      # inner array.
      # Since updating the list is rather cheap, we only sort for now.
      # Sorting is done in a case-insensitive manner by a few simple scoring
      # rules.
      # The best score is given to values that have needle as their beginning.
      # Then come values that include the needle somewhere inside.
      # All others are sorted after that.
      # To account for typos and give relevant similar results, we then refine
      # the score with the levenshtein distance between needle and value.
      # If two values have the same score, they are sorted alphabetically.
      def subset(needle, values, sort_index = 0)
        lower_needle = needle.to_s.downcase

        scored = values.map do |value|
          if value.respond_to?(:to_ary)
            value = value.to_ary
            decider = value[sort_index]
          else
            decider = value
          end

          score = 0
          lower_value = decider.downcase

          if lower_value.start_with?(lower_needle)
            score -= (needle.size + decider.size)
          elsif lower_value.include?(lower_needle)
            score -= decider.size
          end

          score += Levenshtein.distance(lower_needle, lower_value)
          [score, lower_value, value]
        end

        scored.sort.select{|score, lower, value| score < 1 }.map{|score, lower, value| value }
      end

      # Callback after the tree values have changed. Only called if there are
      # any items the tree.
      def after_update
      end

      def tree_selection_value
        return unless item = tree.selection.first
        item.options[:values].first
      end

      def sync_value_with_tree_selection
        return unless value = tree_selection_value
        self.value = value
      end

      # This method is called if a value is chosen (hitting enter)
      # @abstract
      # @param [String] value the selected value.
      # @throw [:invalid] if the value is invalid (aka directory selected in
      #   file dialog and so on)
      # @return [void]
      def action(value)
        l action: value
        raise NotImplementedError, "Implement in subclass"
      end

      def cancel
        callback.destroy
      end

      def next_line
        tree.line_down
      end

      def prev_line
        tree.line_up
      end

      def accept_line
        self.tabcount = 0
        catch(:invalid){ action(tree_selection_value) }
      end

      def speed_selection
        accept_line(event)
      end

      def completion
        self.tabcount += 1

        if tabcount == 1
          update_only
        else
          items = tree.children(nil)

          if items.size == 1
            self.tabcount = 0
          else
            tree.line_down
          end
        end

        sync_value_with_tree_selection
      end
    end
  end
end
