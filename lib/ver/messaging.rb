module VER
  module_function

  def info(message = nil, color = nil)
    return @info unless message
    @info.info_color = color if color
    @info.info = message
    @info
  end

  def status(message = nil, color = nil)
    return @info unless message
    @info.status_color = color if color
    @info.status = message
    @info
  end

  def ask(question = nil, completer = nil, &block)
    return @ask unless question and completer
    @ask.open(question, completer, &block)
    @info.open
  end

  def choice(question = nil, choices = nil, &block)
    return @choice unless question and choices
    @choice.open(question, choices, &block)
    @info.open
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
