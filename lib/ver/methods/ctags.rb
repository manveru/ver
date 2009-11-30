module VER
  module Methods
    module Ctags
      def ctags_find_current
        word = get('insert wordstart', 'insert wordend')
        ctags_find(word)
      end

      def ctags_go(name = nil)
        if name
          ctags_content do |tag_name, file_name, ex_cmd|
            next unless tag_name == name
            return ctags_execute(file_name, ex_cmd)
          end
        else
          status_ask 'Tag name: ' do |tag_name|
            ctags_go(tag_name)
          end
        end
      end

      def ctags_find(needle)
        ctags_content do |tag_name, file_name, ex_cmd|
          next unless tag_name == needle
          return ctags_execute(file_name, ex_cmd)
        end
      end

      def ctags_prev
        if bm = VER.ctag_stack.pop
          bookmark_open(bm)
        else
          message("Tag stack empty.")
        end
      end

      def ctags_execute(file_name, ex_cmd)
        case ex_cmd
        when /^\d+$/
          VER.ctag_stack << Bookmarks::Bookmark.new(nil, *bookmark_value)

          view.find_or_create(file_name, ex_cmd.to_i)
        when /^\/(.*)\/$/
          VER.ctag_stack << Bookmarks::Bookmark.new(nil, *bookmark_value)

          source = $1.gsub(/(?!\\)([()])/, '\\\\\\1')
          regexp = Regexp.new(source)

          self.view.find_or_create(file_name) do |view|
            view.text.tag_all_matching(:search, regexp, Search::SEARCH_HIGHLIGHT)
            view.text.search_next
          end
        else
          raise ArgumentError, "Unknown Ex command: %p" % [ex_cmd]
        end
      end

      def ctags_content
        dir = filename.dirname
        file = nil

        loop do
          file = dir/'tags'
          break if file.file? || dir.root?
          dir = dir.parent
        end

        return unless file.file?

        file.open 'rb' do |io|
          io.each_line do |line|
            head, tail = line.split(/;"\t/, 2)
            yield(*head.split("\t"))
          end
        end
      end
    end
  end
end
