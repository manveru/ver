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

  minor_mode :git_plugin do
    handler Methods::Git
    above :control

    add :git_blame,                        'gitb'
    add [:open_rxvt, 'git add -p'],        'gita'
    add [:open_rxvt, 'git commit'],        'gitc'
    add [:open_rxvt, 'git diff'  ],        'gitd'
    add [:open_rxvt, 'git pull'  ],        'gitpul'
    add [:open_rxvt, 'git push'  ],        'gitpus'
    add [:open_rxvt, 'git status | less'], 'gits'
  end

  minor_mode :control do
    below :git_plugin
  end
end
