module VER
  module Methods
    module Completion
      # TODO: use the tag names at the location to customize completion choices
      # the textmate bundles have quite some stuff for that.
      def smart_tab
        context = get('insert - 1 chars', 'insert + 1 chars')

        if context =~ /^\S\W/
          if @complete_last_used
            complete_again
          else
            complete_snippet
          end
        else
          snippet_jump || complete_fallback
        end
      end

      def complete_fallback
        indent = ' ' * options.shiftwidth
        insert :insert, indent
      end

      def complete_again
        send(@complete_last_used) if @complete_last_used
      end

      def complete_snippet
        return unless load_snippets
        @complete_last_used = :complete_snippet

        snippet_jump || snippet_use
      end

      def snippet_use
        head = get('insert linestart', 'insert')
        name = head[/\S+$/]
        from = index("insert - #{name.size} chars")
        to = index("insert")

        return unless snippet = @snippets[name]
        snippet_insert(from, to, snippet)
      end

      # if there has been a snippet used, most likely some tags or marks were set.
      # jump there, set up selection for replacing the default values.
      def snippet_jump
        1.upto(9) do |n|
          {:range=>[["1.4", "1.15"]]}

          ranges = tag_ranges("ver.snippet.marker_#{n}")
          next unless range = ranges.first

          p range: range

          from, to = range

          status_ask 'Replace with: ', do |string|
            replace(from, to, string)
          end

          return true
        end

        marks = self.mark_names
        mark = marks.sort.find{|name| name =~ /^ver_snippet_marker/ }
        mark ||= :ver_snippet_home if marks.include?(:ver_snippet_home)

        if mark
          snippet_jump_mark(mark)
          true
        else
          false
        end
      end

      def snippet_jump_mark(name)
        mark_set(:insert, "#{name} + 1 chars")
        mark_unset(name)
      end

      # following the rules of tm snippets isn't easy.
      # It is a powerful construct, so we better get this right.
      # First of all, place the insert mark at $0 (and remove $0).
      def snippet_insert(from, to, snippet)
        require 'strscan'
        pp snippet
        exec_bundle

        1.upto(9) do |n|
          tag_configure("ver.snippet.marker_#{n}", background: '#066')
        end

        content = snippet[:content]
        s = StringScanner.new(content)
        indent_size = options.shiftwidth
        indent = ' ' * indent_size

        undo_record do |record|
          record.delete(from, to)

          spos = nil
          until s.eos?
            spos = s.pos

            if s.scan(/\$0/) # $1
              p [:mark_set, :snippet_home, index(:insert)]
              mark_set(:ver_snippet_home, 'insert - 1 chars')
            elsif s.scan(/\$([1-9])/)
              p [:mark_set, s[1], index(:insert)]
              mark_set("ver_snippet_marker_#{s[1]}", 'insert - 1 chars')
            elsif s.scan(/\$\{(\d):([^\}]+)\}/) # ${1:method_name}
              p [:insert, index(:insert), s[2], "ver.snippet.marker_#{s[1]}"]
              record.insert(:insert, s[2], "ver.snippet.marker_#{s[1]}")
            elsif s.scan(/\$\{([^:}]+):([^}]+)\}/)
              string = ENV[s[1]] || `echo "#{s[2]}"`.chomp

              p [:insert, index(:insert), string]
              record.insert(:insert, string)
            elsif s.scan(/\$\{([^:}]+)\}/)
              string = ENV[s[1]]

              p [:insert, index(:insert), string]
              record.insert(:insert, string)
            elsif s.scan(/`([^`]+)`/)
              string = `#{s[1]}`

              p [:insert, index(:insert), string]
              record.insert(:insert, string)
            elsif s.scan(/[^$]+/)
              string = s[0].gsub(/^\t+/){|match| indent * match.size }

              p [:insert, index(:insert), string]
              record.insert(:insert, string)
            else
              p fail: s
              break
            end

            if spos == s.pos
              p fail: s
              break
            end
          end
        end
      rescue => ex
        VER.error(ex)
      end

      def complete_tm
        return unless load_preferences

        @complete_last_used = :complete_tm

        from, to = 'insert - 1 chars wordstart', 'insert - 1 chars wordend'

        complete{ [from, to, tm_completions(from, to)] }
      end

      def tm_completions(from, to)
        tags  = Set.new(tag_names(to))
        completions = []

        @preferences.each do |key, value|
          name, scope, settings, uuid =
            value.values_at('name', 'scope', 'settings', 'uuid')
          scopes = Set.new(scope.split(/\s*,\s*|\s+/))

          next unless completion_command = settings['completionCommand']
          next unless scope_compare(tags, scopes)

          current_word = get(from, to).strip
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
        search_all(/^.*#{needle}.*$/).map{|match, *_| match }.uniq
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

        found = search_all(/(^|\W)(#{prefix}[\w-]*)/).
          sort_by{|match, mf, mt| [Text::Index.new(self, mf).delta(from), match] }.
          map{|match, *_| match.strip[/[\w-]+/] }.uniq
        found.delete prefix
        found
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
        undo_separator
        HoverCompletion.new(self, options, &block)
      end
    end
  end
end
