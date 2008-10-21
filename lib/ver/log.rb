require 'logger'

class Logger
  class Formatter
    def call(severity, time, progname, msg)
      "[%d | %s] %s: %s\n" % [$$, time.strftime("%H:%M:%S"), severity, msg2str(msg)]
    end
  end
end
