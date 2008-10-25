module VER
  module_function

  def info(message)
    View[:info].change{|v| v.buffer[0..-1] = message }
  end

  def status(message)
    View[:status].change{|v| v.buffer[0..-1] = message }
  end

  def ask(question, completer, &block)
    View[:ask].ask(question, completer, &block)
  end

  def warn(message)
    # info(message)
    Log.warn(message)
  end

  def help(topic = 'index')
    help = View[:help]
    help.topic = topic
    View.active = help
  end

  def doc(regexp)
    doc = View[:doc]
    doc.show(regexp)
    View.active = doc
  end

  def error(exception, message = nil)
    if @last_error_message = message
      Log.error(message)
    end

    @last_error = exception
    Log.error(exception)
    info(exception.inspect)
    # View[:error].error(message, exception)
  end
end
