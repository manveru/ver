module VER::Methods
  # TODO: add project directory and Dir.pwd to lookup path, maybe share code
  #       with the project directory lookup
  module CTags
    class << self
      def find_current(text)
        word = text.get('insert wordstart', 'insert wordend')
        find(text, word)
      end

      def prev(text, count = text.prefix_count)
        bm = VER.ctag_stack.pop(count).first

        if bm
          bookmark_open(bm)
        else
          message("Tag stack empty.")
        end
      end

      private

      def go(text, name = nil)
        if name
          content text do |tag_name, file_name, ex_cmd|
            next unless tag_name == name
            return execute(text, file_name, ex_cmd)
          end
        else
          text.status_ask 'Tag name: ' do |tag_name|
            go text, tag_name
          end
        end
      end

      def find(text, needle)
        content text do |tag_name, file_name, ex_cmd|
          next unless tag_name == needle
          return execute(text, file_name, ex_cmd)
        end
      end

      def execute(text, file_name, ex_cmd)
        case ex_cmd
        when /^\d+$/
          VER.ctag_stack << Bookmarks::Bookmark.new(nil, *bookmark_value)

          VER.find_or_create_buffer(file_name, ex_cmd.to_i)
        when /^\/(.*)\/$/
          VER.ctag_stack << Bookmarks::Bookmark.new(nil, *bookmark_value)

          source = $1.gsub(/(?!\\)([()])/, '\\\\\\1')
          regexp = Regexp.new(source)

          VER.find_or_create_buffer(file_name) do |buffer|
            buffer.text.tag_all_matching(Search::TAG, regexp, Search::HIGHLIGHT)
            Search.next(buffer.text)
          end
        else
          raise ArgumentError, "Unknown Ex command: %p" % [ex_cmd]
        end
      end

      def content(text)
        dir = text.filename.dirname
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
