module VER
  module SwitchAction
    # mode switching

    def into_control_mode
      into_mode :control
    end

    def into_replace_mode
      into_mode :replace
    end

    def into_insert_mode
      into_mode :insert
    end

    def into_mode(name)
      return if @mode == name
      left if name == :control
      @view.modes = [name]
    end
  end
end
