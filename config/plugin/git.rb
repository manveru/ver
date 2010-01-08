module VER
  module Methods
    module Git
      def git_add
        open_rxvt do |rxvt|
          rxvt.puts('git add -p')
        end
      end

      def open_rxvt
        frame = Tk::Frame.new(width: 700, height: 400, container: true)
        frame.pack(fill: :both, expand: true)

        cmd = "urxvt -embed #{frame.winfo_id} &"
        p cmd
        `#{cmd}`
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
    end

    vim.in_mode :control do
      includes :git
    end
  end
end
