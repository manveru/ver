module VER
  class Buffer::List < Struct.new(:parent, :frame, :list, :entry, :tag, :callback)
    autoload :Buffer,          'ver/buffer/list/buffer'
    autoload :Grep,            'ver/buffer/list/grep'
    autoload :Methods,         'ver/buffer/list/methods'
    autoload :Window,          'ver/buffer/list/buffer'
    autoload :FuzzyFileFinder, 'ver/buffer/list/fuzzy_file_finder'
    autoload :Syntax,          'ver/buffer/list/syntax'
    autoload :Theme,           'ver/buffer/list/theme'
    autoload :Ex,              'ver/buffer/list/ex'

    class Listbox < Tk::Listbox
      include Keymapped

      attr_accessor :list_buffer

      def cancel
        list_buffer.cancel
      end

      def pick_selection
        list_buffer.pick_selection
      end

      def line_up
        index = curselection.first - 1

        if index >= 0
          selection_clear(0, 'end')
          select_index(index)
        end
      end

      def line_down
        index = curselection.first + 1

        if index < size
          selection_clear(0, 'end')
          select_index(index)
        end
      end

      def select_index(index)
        selection_set(index)
        activate(index)
        see(index)
      end
    end

    def initialize(parent, &block)
      self.parent, self.callback = parent, block

      setup_widgets
      setup_keymap
      setup_events
      on_update
    end

    def setup_widgets
      self.frame = Tk::Frame.new.pack fill: :both, expand: true

      self.list = list = Listbox.new(frame)
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
      list.list_buffer = self

      self.entry = entry = Buffer::Entry.new(frame)
      entry.configure font: VER.options[:font]
      entry.pack fill: :x, expand: false
      entry.focus
      entry.list_buffer = self
    end

    def setup_keymap
      list.keymap = VER.keymap.use(
        widget: list, mode: :list_buffer_list)

      entry.keymap = VER.keymap.use(
        widget: entry, mode: :list_buffer_entry)
    end

    # Setup this event, because Keymap gets very confused when you bind 'Key' and
    # we don't want to break the event-chain anyway
    def setup_events
      entry.bind('<<Inserted>>'){ on_update }
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
      list.line_up
    end

    def line_down
      list.line_down
    end

    def select_index(index)
      list.select_index(index)
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

    def pick_action(*args)
      callback.call(*args) if callback
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
