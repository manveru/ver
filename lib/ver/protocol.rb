module VER
  module Protocol
    # Invoked with ruby objects received over the network
    def receive_object(object)
      raise NotImplementedError
    end

    # Sends a ruby object over the network
    def send_object(object)
      data = Marshal.dump(object)
      send_data [data.bytesize, data].pack('Na*')
    end

    private

    def receive_data(data)
      (@buf ||= '') << data

      while @buf.size >= 4
        if @buf.size >= 4+(size=@buf.unpack('N').first)
          @buf.slice!(0,4)
          receive_object Marshal.load(@buf.slice!(0,size))
        else
          break
        end
      end
    end
  end
end
