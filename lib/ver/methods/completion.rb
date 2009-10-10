module VER
  module Methods
    module Completion
      def complete_file
        files = file_completions
        complete(files)
      end

      def complete_aspell
        words = aspell_completions
        complete(words)
      end

      def file_completions
        word = get('insert wordstart', 'insert wordend')

        glob = "#{word}*{**/*,/**/*}"
        p glob
        Dir[glob].uniq
      end

      def aspell_completions
        word = get('insert wordstart', 'insert wordend')

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

      def complete(words)
        return if words.empty?

        x, y = caret.values_at('x', 'y')
        longest_word = words.map{|word| word.size }.max

        list = Tk::Listbox.new(self){
          borderwidth 0
          width longest_word + 2
          height words.size
          place x: x, y: y
          focus
        }

        list.value = words
        list.selection_set 0

        # go down
        list.bind('j'){|event|
          index = list.curselection.first + 1
          max = list.size

          if index < max
            list.selection_clear(0, 'end')
            list.selection_set(index)
            list.activate(index)
          end

          Tk.callback_break
        }

				# go up
        list.bind('k'){|event|
          index = list.curselection.first - 1

          if index >= 0
            list.selection_clear(0, 'end')
            list.selection_set(index)
            list.activate(index)
          end

          Tk.callback_break
        }

        list.bind('Return'){|event|
          index = list.curselection.first
          replacement = list.get(index)
          replace('insert wordstart', 'insert wordend', replacement)
          focus
          list.destroy
          Tk.callback_break
        }

        list.bind('Escape'){|event|
          focus
          list.destroy
          Tk.callback_break
        }
      end
    end
  end
end