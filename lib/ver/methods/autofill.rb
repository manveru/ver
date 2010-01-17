module VER::Methods
  module AutoFill
    class << self
      def auto_fill_space(text)
        enabled = text.store(self, :enable)
        return text.insert(:insert, ' ') unless enabled

        from, to = 'insert linestart', 'insert lineend'
        line = text.get(from, to)

        if line.size < (text.options.auto_fill_width || 78)
          text.insert(:insert, ' ')
        else
          chunks = line.scan(/(.{1,78}[^\s])(?:\s|$)/)
          lines = chunks.join("\n") << ' '
          text.replace(from, to, lines)
        end
      end
    end
  end
end
