module VER
  class Client < EM::Connection
    include VER::Protocol

    def post_init
      login :username => 'manveru', :password => 'letmein'
    end

    def receive_object(object)
      p :receive_object => object
      object.each do |message, arguments|
        case message
        when :login
          case arguments[:status]
          when :ok
            on_login_success
          end
        else
          p message => arguments
          CHANNEL << {message => arguments}
        end
      end
    end

    def login(args)
      send_object :login => args
    end

    def on_login_success
      Editor.start(self)
    end
  end
end
