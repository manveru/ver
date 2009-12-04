module VER
  # TODO: the positioning behaviour is still annoying, for some reason I
  # just can't get a handle on a changed position. Even using the tk-internal Expose
  # event works only sometimes.
  class HoverCompletion
    attr_reader :parent, :list
    attr_accessor :from, :to, :choices, :options, :completer

    def initialize(parent, options = {}, &completer)
      @parent, @options, @completer = parent, options, completer
      setup_widgets
      setup_keymap
      setup_events
      update
    end

    def setup_widgets
      @list = Tk::Listbox.new(parent, borderwidth: 0, selectmode: :single)
      @list.focus
    end

    def setup_keymap
      keymap_name = VER.options.keymap
      @list_keymap = Keymap.get(name: keymap_name, receiver: self,
                                widget: list, mode: :hover_completion)
    end

    def setup_events
      list.bind('<<ListboxSelect>>'){ layout }
      list.bind('<Expose>'){ layout }
    end

    def go_down
      index = list.curselection.first + 1
      max = list.size

      return unless index < max

      select index
    end

    def go_up
      index = list.curselection.first - 1

      return unless index >= 0

      select index
    end

    def continue_completion
      pick
      options[:continue] ? update : cancel
    end

    def submit
      pick
      cancel
    end

    def pick
      index = list.curselection.first
      replacement = list.get(index)
      parent.replace(from, to, replacement)
    end

    def update
      self.from, self.to, self.choices = completer.call
      @longest_choice = choices.map{|choice| choice.size }.max

      if choices && choices.size > 0
        list.value = choices
        select 0

        submit if choices.size == 1
      else
        cancel
      end
    end

    def select(index)
      list.selection_clear(0, :end)
      list.selection_set(index)
      list.see(index)

      Tk::Event.generate(list, '<<ListboxSelect>>')
    end

    def layout
      return unless choices && choices.size > 0

      x, y, caret_height =
        parent.tk_caret.values_at(:x, :y, :height)

      height, width = parent.winfo_height, parent.winfo_width
      height -= parent.status.winfo_height

      # use side with most space, east or west
      if x > (width / 2)
        side = 'e'
      else
        side = 'w'
      end

      # use hemisphere with most space
      if y < (height / 3)
        hemisphere = 'n'
        y += caret_height
        height -= y
      elsif y < (height / 2)
        hemisphere = ''
        height -= ((height - y) / 2)
      else
        hemisphere = 's'
        height -= (height - y)
      end

      list.configure width: @longest_choice + 2, height: -1
      height = [height, list.winfo_reqheight].min
      width = [width, list.winfo_reqwidth].min

      list.place(
        x: x,
        y: y,
        height: height,
        width: width,
        in: parent,
        anchor: "#{hemisphere}#{side}"
      )
    end

    def cancel
      list.destroy
      parent.focus
    end
  end
end
