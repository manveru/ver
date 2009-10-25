module VER
  class View::List::Ex < View::List
    def initialize(parent, filter, &callback)
      @filter = filter
      super(parent, &callback)
    end

    def update
      list.value = @filter.call(entry.value)
    end

    def pick_selection
      pick_action entry.value
      destroy
    end
  end
end