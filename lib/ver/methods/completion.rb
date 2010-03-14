module VER
  module Methods
    module Completion
      module_function

      # TODO: use the tag names at the location to customize completion choices
      # the textmate bundles have quite some stuff for that.
      def smart_tab(text)
        context = text.get('insert - 1 chars', 'insert + 1 chars')

        if context =~ /^\S\W/
          if text.store(self, :last_used)
            complete_again(text)
          else
            snippet(text)
          end
        else
          Snippet.jump(text) || complete_fallback(text)
        end
      end

      def complete(text, options = {}, &block)
        Undo.separator(text)
        VER::HoverCompletion.new(text, options, &block)
      end

      def complete_fallback(text)
        indent = ' ' * text.options.shiftwidth
        text.insert(:insert, indent)
      end

      def complete_again(text)
        if last_used = text.store(self, :last_used)
          send(last_used, text)
        end
      end

      def aspell(text)
        text.store(self, :last_used, :aspell)

        from = text.index('insert - 1 chars wordstart')
        to   = text.index('insert - 1 chars wordend')
        word = text.get(from, to)

        complete text do
          [from, to, aspell_completions(text, word)]
        end
      end

      def contextual
        return unless text.load_preferences
        text.store(self, :last_used, :contextual)

        from, to = 'insert - 1 chars wordstart', 'insert - 1 chars wordend'

        complete(text) do
          [from, to, contextual_completions(text, from, to)]
        end
      end

      def file(text)
        text.store(self, :last_used, :file)

        complete text, continue: true do
          file_completions(text, 'insert linestart', 'insert')
        end
      end

      def line(text)
        text.store(self, :last_used, :line)

        from, to = 'insert linestart', 'insert lineend'
        lines = line_completions(text, from, to)

        complete(text){ [from, to, lines] }
      end

      def snippet(text)
        return unless text.load_snippets
        text.store(self, :last_used, :snippet)

        Snippet.dwim(text)
      end

      def word(text)
        text.store(self, :last_used, :word)

        y, x = *text.index('insert')
        x = (x - 1).abs
        from, to = text.index("#{y}.#{x} wordstart"), text.index("#{y}.#{x} wordend")

        words = word_completions(text, from, to)

        complete(text){ [from, to, words] }
      end

      def contextual_completions(text, from, to)
        tags  = Set.new(text.tag_names(to))
        completions = []

        text.preferences.each do |key, value|
          name, scope, settings, uuid =
            value.values_at('name', 'scope', 'settings', 'uuid')
          scopes = Set.new(scope.split(/\s*,\s*|\s+/))

          next unless completion_command = settings['completionCommand']
          next unless scope_compare(tags, scopes)

          current_word = text.get(from, to).strip
          ENV['TM_CURRENT_WORD'] = current_word

          tmp = Tempfile.new('ver/complete_tm')
          tmp.print(completion_command)
          tmp.close
          begin
            FileUtils.chmod(0700, tmp.path)
            result = `exec '#{tmp.path}'`
            completions = result.scan(/[^\r\n]+/)
          ensure
            tmp.close!
          end
        end

        completions
      rescue => ex
        VER.error(ex)
      end

      def scope_compare(tags, scopes)
        scopes.all?{|scope| tags.any?{|tag| scope.start_with?(tag) }}
      end

      def line_completions(text, from, to)
        line = text.get(from, to).to_s.strip

        return [] if line.empty?
        needle = Regexp.escape(line)
        text.search_all(/^.*#{needle}.*$/).map{|match, *_| match }.uniq
      end

      # TODO: use filename_under_cursor, that should be much more accurate.
      def file_completions(text, from, to)
        lineno = text.index(from).line
        line = text.get(from, to)

        return [] unless match = line.match(/(?<pre>.*?)(?<path>\/[^\s"'{}()\[\]]*)(?<post>.*?)/)
        from, to = match.offset(:path)
        path = match[:path]

        path.sub!(/\/*$/, '/') if File.directory?(path)

        list = Dir["#{path}*"].uniq - [path]

        list.map! do |item|
          item << '/' if File.directory?(item)
          item.sub(path, '/')
        end

        return "#{lineno}.#{to - 1}", "#{lineno}.#{to}", list
      end

      def word_completions(text, from, to)
        prefix = text.get(from, to).strip
        return [] if prefix.empty?
        prefix = Regexp.escape(prefix)

        found = text.search_all(/(^|\W)(#{prefix}[\w-]*)/).
          sort_by{|match, mf, mt|
            [VER::Text::Index.new(text, mf).delta(from), match]
          }.map{|match, *_| match.strip[/[\w-]+/] }.uniq
        found.delete prefix
        found
      end

      def aspell_completions(text, word)
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
    end
  end
end
