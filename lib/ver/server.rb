require 'eventmachine'

module VER
  class Server < EM::Connection
    include VER::Protocol

    def self.start(host = '127.0.0.1', port = 18014)
      EM.start_server(host, port, self)
    end

    def post_init
      @sid = CHANNEL.subscribe{|m| send_data("#{m.inspect}\n") }
      p :post_init => @sid
    end

    def unbind
      p :unbind => @sid
      CHANNEL.unsubscribe @sid
    end

    def receive_object(object)
      object.each do |message, arguments|
        case message
        when :login
          send_object :login => {:status => :ok}
          EM.defer{ sleep 0.5; send_object(:key => 'C-q') }
        else
          p message => arguments
        end
      end
    end
  end
end
