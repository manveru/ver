module VER
  module Methods
    module Completion
      def complete_file
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
        complete do
          from, to = 'insert wordstart', 'insert wordend'
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