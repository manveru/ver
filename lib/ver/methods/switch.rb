module VER
  module Methods
    # mode switching

    module Switch
      def into_control_mode
        into_mode :control
        Log.debug :cursor => cursor
        left(cursor.bol)
      end

      def into_replace_mode
        into_mode :replace
      end

      def into_insert_mode
        into_mode :insert
      end

      def into_mode(name)
        return if mode == name
        view.modes = [name]
      end
    end
  end
end
