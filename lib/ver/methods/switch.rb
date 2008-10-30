module VER
  module Methods
    module Switch
      def into_control_mode
        view.selection = nil
        left(cursor.bol) if into_mode(:control)
      end

      def into_replace_mode
        view.selection = nil
        into_mode :replace
      end

      def into_insert_mode
        view.selection = nil
        into_mode :insert
      end

      def into_mode(name)
        return if mode == name
        view.mode = name
      end
    end
  end
end
