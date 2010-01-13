module VER
  module Methods
    module Git
      def git_blame(count = 1)
        line = index(:insert).y
        from, to = line - count, line + count
        open_rxvt("git blame #{filename} -L#{from},#{to}")
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
      key :git_blame,                        %w[g i t b]
      key [:open_rxvt, 'git add -p'],        %w[g i t a]
      key [:open_rxvt, 'git commit'],        %w[g i t c]
      key [:open_rxvt, 'git diff'  ],        %w[g i t d]
      key [:open_rxvt, 'git pull'  ],        %w[g i t p u l]
      key [:open_rxvt, 'git push'  ],        %w[g i t p u s]
      key [:open_rxvt, 'git status | less'], %w[g i t s]
    end

    vim.in_mode :control do
      inherits :git
    end
  end
end
