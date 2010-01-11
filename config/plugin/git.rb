module VER
  module Methods
    module Git
      def git_add
        open_rxvt('git add -p')
      end

      def git_commit
        open_rxvt('git ci')
      end

      def open_rxvt(command)
        frame = Tk::Frame.new(container: true)
        frame.pack(fill: :both, expand: true)
        frame.bind('<Destroy>'){ focus }

        cmd = "urxvt -embed #{frame.winfo_id} -e $SHELL -c %p &" % [command]
        p cmd
        `#{cmd}`
        frame.focus
      end
    end

    include Git
  end

  class Text
    include Methods::Git
  end

  if vim = Keymap[:vim]
    vim.in_mode :git do
      key :git_add, %w[g i t a d d]
      key :git_commit, %w[g i t c i]
    end

    vim.in_mode :control do
      includes :git
    end
  end
end
