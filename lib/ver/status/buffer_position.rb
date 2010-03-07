module VER
  class Status
    class BufferPosition < Label
      def setup
        register :position
      end

      def to_s
        buffers = VER.buffers.to_a
        format % [
          buffers.index(buffer).to_i + 1,
          buffers.size
        ]
      end
    end
  end
end
