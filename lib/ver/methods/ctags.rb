module VER
  module Methods
    module Ctags
      def ctags_find_current
        word = get('insert wordstart', 'insert wordend')
        ctags_find(word)
      end

      def ctags_find(needle)
        ctags_content do |tag_name, file_name, ex_cmd|
          next unless tag_name == needle
          return ctags_execute(file_name, ex_cmd)
        end
      end

      def ctags_execute(file_name, ex_cmd)
        case ex_cmd
        when /^\d+$/
          view.find_or_create(file_name, ex_cmd.to_i)
        when /^\/(.*)\/$/
          source = $1.gsub!(/(?!\\)([()])/, '\\\\\\1')
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
