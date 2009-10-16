module VER
  module Methods
    module Completion
      def complete_file
        complete do
          file_completions('insert linestart', 'insert')
        end
      end

      def file_completions(from, to)
        y = index(from).split('.').first
        line = get(from, to)

        return [] unless match = line.match(/(?<pre>.*?)(?<path>\/[^\s"'{}()\[\]]*)(?<post>.*?)/)
        from, to = match.offset(:path)
        path = match[:path]

        if File.directory?(path)
          path.sub!(/\/*$/, '/')
        end

        # p path: path, from: from, to: to

        list = Dir["#{path}*"].uniq - [path]

        list.map! do |item|
          item << '/' if File.directory?(item)
          item.sub(path, '/')
        end

        # pp list

        return "#{y}.#{to - 1}", "#{y}.#{to}", list
      end

      def complete_word
        complete do
          from, to = 'insert wordstart', 'insert wordend'
          [rom, to, word_completions(from, to)]
        end
      end

      def word_completions(from, to)
        prefix = get(from, to)
        prefix = Regexp.escape(prefix)
        search_all(/\b#{prefix}\S+\b/).map{|match, from, to| match }.uniq.sort
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

      def complete(&block)
        CompletionDrop.new(self, &block)
      end

      class CompletionDrop
        attr_reader :parent, :list
        attr_accessor :from, :to, :choices, :completer

        def initialize(parent, &completer)
          @parent, @completer = parent, completer
          setup
          update
        end

        def setup
          @list = Tk::Listbox.new(parent){
            borderwidth 0
            selectmode :single
            focus
          }

          setup_bindings
        end

        def setup_bindings
          list.bind('j'){|event|
            go_down
          }

          list.bind('k'){|event|
            go_up
          }

          list.bind('l'){|event|
            start_next_completion
          }

          list.bind('Return'){|event|
            pick
            Tk.event_generate(list, '<ListboxCancel>')
          }

          list.bind('Escape'){|event|
            Tk.event_generate(list, '<ListboxCancel>')
          }

          list.bind('<ListboxSelect>'){|event|
            layout
          }

          # list.bind('<ListboxCancel>'){|event|
          #  destroy
          #}

          events = %w[
            Activate
            Destroy
            Map
            ButtonPress
            Enter
            MapRequest
            ButtonRelease
            Motion
            Circulate
            FocusIn
            MouseWheel
            FocusOut
            Property
            Colormap
            Gravity
            Reparent
            Configure
            KeyPress
            ResizeRequest
            ConfigureRequest
            KeyRelease
            Unmap
            Create
            Leave
            Visibility
            Deactivate
          ]
            # CirculateRequest
            # Expose

          events.each do |name|
            # p name
            # parent.bind("#{name}"){|event| p(parent: name, e: event) }
            # list.bind("#{name}"){|event|   p(list:   name, e: event) }
          end

          parent.bind('Expose'){|event| layout }
        end

        def go_down
          index = list.curselection.first + 1
          max = list.size

          return unless index < max

          select index
        end

        def go_up
          index = list.curselection.first - 1

          return unless index >= 0

          select index
        end

        def start_next_completion
          pick
          update
        end

        def pick
          index = list.curselection.first
          replacement = list.get(index)
          parent.replace(from, to, replacement)
        end

        def update
          self.from, self.to, self.choices = completer.call

          if choices && choices.size > 0
            list.value = choices
            select 0
            layout
          else
            cancel
          end
        end

        def layout
          return unless choices && choices.size > 0
          # list.place_forget
          longest_choice = choices.map{|choice| choice.size }.max
          list.configure width: longest_choice + 2, height: 20
          x, y = parent.caret.values_at('x', 'y')
          list.place x: x, y: y
        end

        def select(index)
          list.selection_clear(0, :end)
          list.selection_set(index)
          list.see(index)
          Tk.event_generate(list, '<ListboxSelect>')
        end

        def cancel
          destroy
        end

        def destroy
          list.destroy
          parent.focus
        end

        def dbg
          x, y = parent.caret.values_at('x', 'y')
          {x: x, y: y}
        end
      end
    end
  end
end