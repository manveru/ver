module VER
  module Methods
    module Insert
      def insert_selection
        insert :insert, TkSelection.get
      end
    end
  end
end