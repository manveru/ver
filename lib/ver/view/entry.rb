module VER
  class View
    class Entry < VER::Entry
      attr_accessor :list_view

      def pick_first
        list_view.pick_first
      end

      def cancel
        list_view.cancel
      end
    end
  end
end