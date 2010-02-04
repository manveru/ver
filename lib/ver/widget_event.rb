module VER
  # This class acts as a proxy for the widget.
  # it forwards all methods, except for [event], which points to the event
  # currently invoked.
  #
  # This is done to allow methods operating on the widget to obtain information
  # about the event, so they can act intelligently.
  #
  # The usage of [method_missing] might make it a bit slower right after
  # startup, but should be next to no difference to a direct reference of widget
  # as we dynamically define the methods handled.
  #
  # Due to the dynamic nature of ruby, what widget is underneath will not make
  # any difference, and WidgetEvent will be more or less invisible outside of
  # backtraces.
  class WidgetEvent < BasicObject
    attr_reader :widget, :event

    def initialize(widget, event)
      @widget, @event = widget, event
    end

    def respond_to?(method)
      method.to_sym == :event || @widget.respond_to?(method)
    end

    def method_missing(method, *args, &block)
      # ::Kernel.p([@widget, @event] => [method, args])
      result = @widget.send(method, *args, &block)

      if method =~ /=/
        ::VER::WidgetEvent.class_eval(<<-RUBY, __FILE__, __LINE__)
          def #{method}(arg)
            @widget.#{method} arg
          end
        RUBY
      else
        ::VER::WidgetEvent.class_eval(<<-RUBY, __FILE__, __LINE__)
          def #{method}(*args, &block)
            @widget.#{method}(*args, &block)
          end
        RUBY
      end

      result
    end
    alias send method_missing
  end
end
