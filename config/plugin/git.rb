# Copyright (c) 2010 Michael Fellinger <m.fellinger@gmail.com>
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
        line = text.index(:insert).line
        from, to = line - count, line + count
        spawn_rxvt(text, "git blame #{text.filename} -L#{from},#{to}")
      end

      def self.spawn_rxvt(text, command)
        Preview.spawn_rxvt(command)
      end

      def self.spawn_cmd(text, command)
        `#{command} &`
      end
    end
  end

  if options.keymap == 'vim'
    minor_mode :control do
      inherits :git
    end

    minor_mode :git do
      handler Methods::Git

      map :git_blame,                  'gitb'
      map [:spawn_rxvt, 'git add -p'], 'gita'
      map [:spawn_rxvt, 'git commit'], 'gitc'
      map [:spawn_rxvt, 'git diff'  ], 'gitd'
      map [:spawn_rxvt, 'git pull'  ], 'gitpul'
      map [:spawn_rxvt, 'git push'  ], 'gitpus'
      map [:spawn_rxvt, 'git status'], 'gitst'
      map [:spawn_rxvt, 'tig'],        'gitt'
      map [:spawn_cmd,  'gitk --all'], 'gitk'
    end
  end
end
