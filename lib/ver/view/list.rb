module VER
  class View::List < Struct.new(:parent, :frame, :list, :entry, :tag, :callback)
    autoload :Buffer,          'ver/view/list/buffer'
    autoload :Grep,            'ver/view/list/grep'
    autoload :Methods,         'ver/view/list/methods'
    autoload :Window,          'ver/view/list/buffer'
    autoload :FuzzyFileFinder, 'ver/view/list/fuzzy_file_finder'
    autoload :Syntax,          'ver/view/list/syntax'
    autoload :Theme,           'ver/view/list/theme'
    autoload :Ex,              'ver/view/list/ex'

    def initialize(parent, &block)
      self.parent, self.callback = parent, block

      setup_widgets
      setup_keymap
      setup_events
      on_update
    end

    def setup_widgets
      self.frame = Tk::Frame.new.pack fill: :both, expand: true

      self.list = list = Tk::Listbox.new(frame)
      list.configure(
        setgrid: true,
        width: 0,
        background: '#000',
        foreground: '#fff',
        selectforeground: '#000',
        selectbackground: '#fff',
        exportselection: false,
        font: VER.options[:font]
      )
      list.pack fill: :both, expand: true

      self.entry = entry = View::Entry.new(frame)
      entry.configure font: VER.options[:font]
      entry.pack fill: :x, expand: false
      entry.focus
      entry.list_view = self
    end

    def setup_keymap
      keymap_name = VER.options.fetch(:keymap)

      @list_keymap = Keymap.get(
        name: keymap_name, receiver: self, widget: list, mode: :list_view_list)

      @entry_keymap = Keymap.get(
        name: keymap_name, receiver: entry, widget: entry, mode: :list_view_entry)
    end

    # Setup this event, because Keymap gets very confused when you bind 'Key' and
    # we don't want to break the event-chain anyway
    def setup_events
      entry.bind('<<Modified>>'){ on_update }
    end

    def on_update
      update
      list.selection_set(0)
      list.activate(0)
    end

    def quit
      VER.exit
    end

    def line_up
      index = list.curselection.first - 1

      if index >= 0
        list.selection_clear(0, 'end')
        select_index(index)
      end
    end

    def line_down
      index = list.curselection.first + 1
      max = list.size

      if index < max
        list.selection_clear(0, 'end')
        select_index(index)
      end
    end

    def select_index(index)
      list.selection_set(index)
      list.activate(index)
      list.see(index)
    end

    def cancel
      destroy
    end

    def destroy
      entry.destroy
      list.destroy
      frame.destroy
      parent.focus
    end

    def sublist(list, input = entry.value)
      if input == input.downcase
        list.select{|item| item.to_s.downcase.include?(input) }
      else
        list.select{|item| item.to_s.include?(input) }
      end
    end

    def pick(item)
      if list.size > 0
        pick_action(item)
        destroy
      else
        message "VER is confused, what did you actually want to do?"
      end
    end

    def pick_first
      pick list.get(0)
    end

    def pick_selection
      pick list.get(list.curselection.first)
    end

    def pick_action(item)
      callback.call(item) if callback
    end

    def completion
      values = list.get(0, :end)

      if values.size == 1
        entry.value = values.first
      elsif values.size > 1
        require 'abbrev'
        if found = values.abbrev[entry.value]
          entry.value = found
        end
      end
    end

    def message(string)
      parent.status.message(string)
    end
  end
end
