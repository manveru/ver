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

      # keymap callbacks

      def completion
        callback.completion do |entry_value|
          values = yield(entry_value)
          tree.clear
          first = nil
          values.each do |value|
            item = tree.insert(nil, :end, text: value)
            first ||= item
          end

          return unless first

          first.focus
          first.selection_set
        end
      rescue => ex
        VER.error(ex)
      end

      def pick_selection
        callback.complete_or_pick do |value|
          callback.destroy if yield(value)
        end
      rescue => ex
        VER.error(ex)
      end

      def speed_selection
        completion
        pick_selection
        pick_selection
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

    class CompleteFile < Entry
      def completion
        super do |origin|
          Dir.glob("#{origin}*").map do |path|
            if File.directory?(path)
              path = "#{path}/"
            end

            path
          end
        end
      end

      def pick_selection
        super do |path|
          callback.caller.view.find_or_create(path)
          true
        end
      end
    end

    class CompleteMethod < Entry
      def completion
        super do |name|
          callback.caller.methods.sort.grep(/#{Regexp.escape(name)}/i)
        end
      end

      def pick_selection
        super do |method|
          callback.caller.__send__(method)
          true
        end
      end
    end

    class CompleteLabel < Entry
      COMPLETERS = {
        'edit'  => CompleteFile,
        'open'  => CompleteFile,
        'write' => CompleteFile,
        'method' => CompleteMethod,
      }

      def completion
        super do |name|
          regex = /#{Regexp.escape(name)}/i
          COMPLETERS.keys.select{|key| key =~ regex }
        end
      end

      def pick_selection
        super do |name|
          entry = callback.use_entry(COMPLETERS.fetch(name))
          entry.focus
          false
        end
      end
    end

    attr_reader :caller, :tree

    def initialize(caller)
      @caller = caller
      @last_was_tab = false

      setup_widgets
      setup_tree
      setup_bindings

      @label.callback = self
      @label.mode = :open_path_entry
      @label.focus

      @active = @label
    end

    def setup_widgets
      @frame = Tk::Tile::Frame.new(VER.root)
      @label = CompleteLabel.new(@frame)
      @tree  = Tk::Tile::Treeview.new(@frame)

      @frame.place(anchor: :n, relx: 0.5, relwidth: 0.8)

      @label.grid_configure(row: 0 ,column: 0, sticky: :w)
      @tree. grid_configure(row: 1, column: 0, columnspan: 2, sticky: :nswe)
      @tree. grid_forget

      @frame.grid_rowconfigure(0, weight: 1)
      @frame.grid_rowconfigure(1, weight: 2)
      @frame.grid_columnconfigure(0, weight: 0)
      @frame.grid_columnconfigure(1, weight: 2)
    end

    def use_entry(klass)
      @entry = klass.new(@frame)
      @entry.grid_configure(row: 0, column: 1, sticky: :we)
      @entry.callback = self
      @entry.mode = :open_path_entry
      @active = @entry
      setup_bindings
      @entry
    end

    def setup_tree
      @tree.heading '#0', text: 'Path'
    end

    def setup_bindings
      [@entry, @label].compact.each do |widget|
        widget.bind('<<Deleted>>') do
          @last_was_tab = false
        end

        widget.bind('<<Inserted>>') do
          @last_was_tab = false
        end
      end
    end

    def destroy
      label: @label.destroy
      entry: @entry.destroy
      tree: @tree.destroy
      frame: @frame.destroy
      caller: @caller.focus
    end

    def completion
      @tree.grid_configure(row: 1, column: 0, columnspan: 2, sticky: :nswe)

      if @last_was_tab
        # Make sure that we don't automatically venture deeper if there are
        # multiple choices.
        # We simply go down the list of choices and update the entry value.
        # If there was only one choice, we go deeper once.
        children = @tree.children(nil)

        if children.size == 1
          item = children.first
          @active.value = value = item.options(:text).to_s
          yield(value)
        else
          item = @tree.focus_item.next

          if item.id == ''
            item = @tree.children(nil).first
          end

          item.focus
          item.see
          item.selection_set
        end
      else
        # seems the user did input something since last time, build a new
        # list.
        yield(@active.value)
      end

      @last_was_tab = true
    rescue => ex
      VER.error(ex)
    end

    def complete_or_pick
      if @last_was_tab
        # the user might want to complete with the current focused one
        item = @tree.focus_item
        text = item.options(:text).to_s
        @active.value = text
      else
        # the user accepts the input?
        yield(@active.value)
      end

      @last_was_tab = false
    rescue => ex
      VER.error(ex)
    end
  end
end
