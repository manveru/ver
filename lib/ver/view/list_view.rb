module VER
  class ListView < Struct.new(:parent, :frame, :list, :entry, :tag, :callback)
    def initialize(parent, &block)
      self.parent, self.callback = parent, block

      setup_widgets
      setup_tag
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

      self.entry = Ttk::Entry.new(frame){
        pack fill: :x, expand: false
        focus
      }
    end

    def setup_tag
      self.tag = TkBindTag.new
      tags = entry.bindtags
      tags[tags.index(entry.class) + 1, 0] = tag
      entry.bindtags = tags

      tag.bind('Key'){       update }
      tag.bind('Return'){    pick }
      tag.bind('Escape'){    destroy }
      tag.bind('Control-c'){ destroy }
    end

    def destroy
      entry.destroy
      list.destroy
      frame.destroy
      parent.focus
    end

    def pick
      if list.size > 0
        callback.call(list.get(0)) if callback
        destroy
      else
        message "VER is confused, what did you actually want to do?"
      end
    end

    def message(string)
      parent.status.message(string)
    end
  end
end
