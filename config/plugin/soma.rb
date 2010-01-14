# Copyright (c) 2009 Michael Fellinger <m.fellinger@gmail.com>
#
# Description:
#
# This provides a shortcut to talk with a Soma irb instance.
# Soma is available as a gem called "soma" or from
# http://github.com/ichverstehe/soma
#
# Note that you can have only one irb console using Soma at a time.
#
# Usage:
#
# Put following line into your rc.rb
#   VER.plugin :soma
#
# Install Soma, and open an irb console.
# Then type following:
#   require 'soma'
#   Soma.start
#
# Now you can open any file in VER and press <Control-c> <Control-c> to send the
# contents to irb.

require 'tmpdir'

module VER
  module Methods
    module Soma
      def soma_buffer
        soma_tempfile.open('w+'){|io| io.write(value) }
      end

      private

      def soma_tempfile
        Pathname(Dir.tmpdir)/"#{`whoami`.strip}_somarepl_buffer"
      end
    end # Soma

    include Soma
  end # Methods

  class Text
    include Methods::Soma
  end # Text

  if vim = Keymap[:vim]
    vim.in_mode :soma do
      key :soma_buffer, %w[Control-c Control-c]
    end

    vim.in_mode :control do
      inherits :soma
    end
  end
end # VER
