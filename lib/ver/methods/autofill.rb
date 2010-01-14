module VER
  module Methods
    module AutoFill
      attr_accessor :auto_fill

      def auto_fill_space
        return insert(:insert, ' ') unless auto_fill

        from, to = 'insert linestart', 'insert lineend'
        line = get(from, to)

        if line.size < (options.auto_fill_width || 78)
          insert(:insert, ' ')
        else
          chunks = line.scan(/(.{1,78}[^\s])(?:\s|$)/)
          lines = chunks.join("\n") << ' '
          replace(from, to, lines)
        end
      end
    end
  end
end
