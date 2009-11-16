module VER
  module Methods
    module Shortcuts
      include Move, Save, Views, Insert

      alias q view_close
      alias q! quit
      alias w file_save
      alias r insert_file_contents

      def wq
        w and q
      end
    end
  end
end
