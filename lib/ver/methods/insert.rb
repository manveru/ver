module VER
  module Methods
    module Insert
      def insert_selection
        insert :insert, Tk::Selection.get
      end
    end
  end
end
