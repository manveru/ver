module VER
  class View::List < Struct.new(:parent, :frame, :list, :entry, :tag, :callback)
    autoload :Buffer,          'ver/view/list/buffer'
    autoload :FuzzyFileFinder, 'ver/view/list/fuzzy_file_finder'
    autoload :Syntax,          'ver/view/list/syntax'
    autoload :Theme,           'ver/view/list/theme'

    def initialize(parent, &block)
      self.parent, self.callback = parent, block

      setup_widgets
      setup_keymap
      setup_events
      update
    end

    def setup_widgets
      self.frame = TkFrame.new{
        pack fill: :both, expand: true
      }

      self.list = Tk::Listbox.new(frame){
        setgrid 'yes'
        width 0
        pack fill: :both, expand: true
      }

      self.entry = View::Entry.new(frame){
        pack fill: :x, expand: false
        focus
      }
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
      entry.bind('<Modified>'){ update }
    end

    def quit
      Tk.exit
    end

    def go_line_up
      p :go_line_up
    end

    def go_line_down
      p :go_line_down
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
        list.select{|item| item.downcase.include?(input) }
      else
        list.select{|item| item.include?(input) }
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
      pick TkSelection.get
    end

    def pick_action(item)
      callback.call(item) if callback
    end

    def message(string)
      parent.status.message(string)
    end
  end
end