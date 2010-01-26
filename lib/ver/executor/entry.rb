module VER
  class Executor
    class Entry < VER::Entry
      include Keymapped

      attr_accessor :parent, :callback
      attr_reader :caller, :tree

      def initialize(parent, options = {})
        @callback = options.delete(:callback)
        @caller   = @callback.caller
        @tree     = @callback.tree

        mode = options.delete(:mode)
        options[:style] ||= VER.obtain_style_name('ExEntry', 'TEntry')

        super

        self.parent = parent
        self.major_mode = :Executor
        self.minor_mode(:executor_label, mode) if mode
      end

      def setup
      end

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
      def subset(needle, values)
        lower_needle = needle.to_s.downcase

        sorted = values.sort_by do |value|
          if value.respond_to?(:to_ary)
            value = value.to_ary.first
          end

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

      def completion(event = nil)
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

      def pick_selection(event = nil)
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

      def speed_selection(event = nil)
        completion
        pick_selection
        pick_selection
        entry = callback.entry
        entry.completion if entry
      rescue => ex
        VER.error(ex)
      end

      def cancel(event = nil)
        callback.destroy
      end

      LINE_UP = <<-'TCL'.strip
set children [%path% children {}]
set children_length [llength $children]

if { $children_length > 1 } {
  set item [%path% prev [%path% focus]]

  if { $item == {} } { set item [lindex $children [expr $children_length - 1]] }

  %path% focus $item
  %path% see $item
  %path% selection set $item
}
      TCL

      # Go one item in the tree up, wraps around to the bottom if the first item
      # has focus.
      #
      # Some lists may be huge, so we handle this in tcl to avoid lots of
      # useless traffic between tcl and ruby.
      # My apologies.
      def line_up(event = nil)
        Tk.eval(LINE_UP.gsub(/%path%/, tree.tk_pathname))
      end

      LINE_DOWN = <<-'TCL'.strip
set children [%path% children {}]
set children_length [llength $children]

if { $children_length > 1 } {
  set item [%path% next [%path% focus]]

  if { $item == {} } { set item [lindex $children 0] }

  %path% focus $item
  %path% see $item
  %path% selection set $item
}
      TCL

      # Go one line in the tree down, wraps around to the top if the last item
      # has focus.
      #
      # Some lists may be huge, so we handle this in tcl to avoid lots of
      # useless traffic between tcl and ruby.
      # My apologies.
      def line_down(event = nil)
        Tk.eval(LINE_DOWN.gsub(/%path%/, tree.tk_pathname))
      end
    end
  end
end
