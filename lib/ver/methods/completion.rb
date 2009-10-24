module VER
  module Methods
    module Completion
      # TODO: use the tag names at the location to customize completion choices
      # the textmate bundles have quite some stuff for that.
      def smart_tab
        context = get('insert - 1 chars', 'insert + 1 chars')

        if @complete_last_used && context =~ /^\S\s/
          complete_again
        else
          insert :insert, '  '
        end
      end

      def complete_again
        send(@complete_last_used) if @complete_last_used
      end

      def complete_line
        @complete_last_used = :complete_line

        from, to = 'insert linestart', 'insert lineend'
        lines = line_completions(from, to)

        complete{ [from, to, lines] }
      end

      def line_completions(from, to)
        line = get(from, to).to_s.strip

        return [] if line.empty?
        needle = Regexp.escape(line)
        search_all(/^.*#{needle}.*$/).map{|match, from, to| match }.uniq
      end

      def complete_file
        @complete_last_used = :complete_file

        complete continue: true do
          file_completions('insert linestart', 'insert')
        end
      end

      def file_completions(from, to)
        y = index(from).y
        line = get(from, to)

        return [] unless match = line.match(/(?<pre>.*?)(?<path>\/[^\s"'{}()\[\]]*)(?<post>.*?)/)
        from, to = match.offset(:path)
        path = match[:path]

        path.sub!(/\/*$/, '/') if File.directory?(path)

        list = Dir["#{path}*"].uniq - [path]

        list.map! do |item|
          item << '/' if File.directory?(item)
          item.sub(path, '/')
        end

        return "#{y}.#{to - 1}", "#{y}.#{to}", list
      end

      def complete_word
        @complete_last_used = :complete_word

        y, x = index('insert').split
        x = (x - 1).abs
        from, to = index("#{y}.#{x} wordstart"), index("#{y}.#{x} wordend")

        words = word_completions(from, to)

        complete{ [from, to, words] }
      end

      def word_completions(from, to)
        prefix = get(from, to).strip
        return [] if prefix.empty?
        prefix = Regexp.escape(prefix)
        search_all(/\b#{prefix}\w*/).map{|match, from, to| match }.uniq
      end

      def complete_aspell
        @complete_last_used = :complete_aspell

        complete do
          pos = index('insert - 1 chars')
          from, to = pos.wordstart, pos.wordend
          [from, to, aspell_completions(from, to)]
        end
      end

      def aspell_completions(from, to)
        word = get(from, to)

        if result = aspell_execute(word)[word]
          result[:suggestions]
        else
          [word]
        end
      end

      ASPELL_PARSE = /^& (.*?) (\d+) (\d+): (.*)$/

      def aspell_execute(word)
        require 'open3'
        results = {}

        Open3.popen3("aspell pipe") do |stdin, stdout, stderr|
          stdin.print("^#{word}")
          stdin.close
          result = stdout.read

          result.scan(ASPELL_PARSE) do |original, count, offset, suggestions|
            results[original] = {
              count: count.to_i,
              offset: offset.to_i,
              suggestions: suggestions.split(/\s*,\s*/),
            }
          end
        end

        return results
      end

      def complete(options = {}, &block)
        HoverCompletion.new(self, options, &block)
      end
    end
  end
end