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
