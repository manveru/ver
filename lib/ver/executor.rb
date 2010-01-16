module VER
  class Executor
    autoload :Entry,   'ver/executor/entry'
    autoload :ExLabel, 'ver/executor/label'

    attr_reader :caller, :tree, :entry, :frame
    attr_accessor :update_on_change

    def initialize(caller)
      @caller = caller
      @last_was_tab = false

      setup_widgets
      setup_bindings

      @active = @label
      @label.setup
      @label.focus
    end

    def setup_widgets
      @frame = Tk::Tile::Frame.new(VER.root)
      @tree  = Tk::Tile::Treeview.new(@frame)
      @label = ExLabel.new(@frame, callback: self)

      @frame.place(anchor: :n, relx: 0.5)

      @label.grid_configure(row: 0 ,column: 0, sticky: :w)
      @tree. grid_configure(row: 1, column: 0, columnspan: 2, sticky: :nswe)
      @tree. grid_forget

      @frame.grid_rowconfigure(0, weight: 0)
      @frame.grid_rowconfigure(1, weight: 2)
      @frame.grid_columnconfigure(0, weight: 0)
      @frame.grid_columnconfigure(1, weight: 2)
    end

    def use_entry(klass)
      @entry = klass.new(@frame, callback: self, mode: :executor_entry)
      @entry.grid_configure(row: 0, column: 1, sticky: :we)
      @active = @entry
      setup_bindings
      @entry.setup
      @entry
    end

    def setup_bindings
      [@entry, @label].compact.each do |widget|
        widget.bind('<<Deleted>>') do
          @last_was_tab = false
        end

        widget.bind('<<Inserted>>') do
          if update_on_change
            @active.completion
            @last_was_tab = false
          else
            @last_was_tab = false
          end
        end
      end
    end

    def destroy
      @label.destroy
      @entry.destroy if @entry
      @tree.destroy
      @frame.destroy
      @caller.focus
    end

    def completion
      @tree.grid_configure(row: 1, column: 0, columnspan: 2, sticky: :nswe)
      @frame.place(relwidth: 0.9)

      if @last_was_tab
        # Make sure that we don't automatically venture deeper if there are
        # multiple choices.
        # We simply go down the list of choices and update the entry value.
        # If there was only one choice, we go deeper once.
        children = @tree.children(nil)

        if children.size == 1
          item = children.first
          value = item.options(:values).first
          @active.value = value
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
        values = item.options(:values)
        @active.completed = values
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
