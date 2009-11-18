module VER
  module Methods
    module Shortcuts
      include Move, Save, Open, Views, Insert

      alias q view_close
      alias q! quit
      alias w file_save
      alias r insert_file_contents
      alias e open_path

      def wq
        w and q
      end
    end
  end
end
