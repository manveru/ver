module VER
  module Methods
    module Shortcuts
      include Move, Save, Views

      alias q view_close
      alias q! quit
      alias w file_save

      def wq
        w and q
      end
    end
  end
end
