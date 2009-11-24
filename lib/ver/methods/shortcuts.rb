module VER
  module Methods
    module Shortcuts
      include Move, Save, Open, Views, Insert

      alias q view_close
      alias q! quit
      alias w file_save
      alias r insert_file_contents
      alias e open_path
      alias o view_find_or_create
      alias bn view_focus_next
      alias bp view_focus_prev
      alias bd view_close

      def wq
        w and q
      end
    end
  end
end
