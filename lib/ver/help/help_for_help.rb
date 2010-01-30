module VER
  module Help
    class HelpForHelp
      def initialize(parent)
        @parent = parent
        setup_widgets
        setup_tags
      end

      def setup_widgets
        font, tabs = VER.options.values_at(:font, :tabs)

        @text = Tk::Text.new(@parent,
          autoseparators:   true, # insert separators into the undo flow
          borderwidth:      0,
          exportselection:  true, # copy into X11 buffer automatically
          font:             font,
          insertofftime:    0, # blinking cursor be gone!
          setgrid:          true, # tell the wm that this is a griddy window
          takefocus:        true,
          tabs:             tabs,
          tabstyle:         :wordprocessor,
          undo:             true, # enable undo capabilities
          wrap:             :word
        )
        @text.pack
        @text.insert(:end, <<-'HELP')
Welcome to the internal Help system of VER.
You most likely got here by pressing [<Help.help_for_help>].

You can close the help using [<Buffers.view_close>].
        HELP
      end

      def setup_tags
      end
    end
  end
end
