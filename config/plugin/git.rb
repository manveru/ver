# Copyright (c) 2009 Michael Fellinger <m.fellinger@gmail.com>
#
# Description:
#
# Shortcuts to use git within VER.
# This simply opens an urxvt console and embeds it into VER until you finish
# interacting with git.
#
# Usage:
#
# Put following line into your rc.rb
#   VER.plugin :git

module VER
  module Methods
    module Git
      def self.git_blame(text, count = 1)
        line = text.index(:insert).y
        from, to = line - count, line + count
        open_rxvt(text, "git blame #{text.filename} -L#{from},#{to}")
      end

      def self.open_rxvt(text, command)
        frame = Tk::Frame.new(container: true)
        frame.pack(fill: :both, expand: true)
        frame.bind('<Destroy>'){ text.focus }

        cmd = "urxvt -embed #{frame.winfo_id} -e $SHELL -c %p &" % [command]
        p cmd
        `#{cmd}`
        frame.focus
      end
    end
  end

  if options.keymap == 'vim'
    minor_mode :control do
      inherits :git
    end

    minor_mode :git do
      handler Methods::Git

      map :git_blame,                        %w[g i t b]
      map [:open_rxvt, 'git add -p'],        %w[g i t a]
      map [:open_rxvt, 'git commit'],        %w[g i t c]
      map [:open_rxvt, 'git diff'  ],        %w[g i t d]
      map [:open_rxvt, 'git pull'  ],        %w[g i t p u l]
      map [:open_rxvt, 'git push'  ],        %w[g i t p u s]
      map [:open_rxvt, 'git status | less'], %w[g i t s]
    end
  end
end
