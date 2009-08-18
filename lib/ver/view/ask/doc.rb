require 'ver/levenshtein'

module VER
  class View
    # Show methods based on patterns.
    #
    # TODO: handle C and evaled methods.
    class AskDoc < AskLarge
      module Methods
        include AskLarge::Methods

        def pick
          return unless choice = view.pick
          return unless method = choice[:method]

          if location = method.source_location
            filename, line = location

            if ::File.file?(filename)
              view.close
              file = View[:file]
              file.buffer = filename
              file.methods.goto_line(line)
              file.open
            else # defined by clumsy eval
              VER.warn method
              VER.warn method.source_location
              VER.warn method.parameters
            end
          else # C method?
            VER.warn method
            VER.warn method.source_location
            VER.warn method.parameters
          end
        end
      end

      DEFAULT = {
        :interactive => true,
        :mode => :ask_doc,
      }

      def initialize(name = :ask_doc, options = {})
        super

        @buffer = MemoryBuffer.new(:ask_doc)
        @prompt = 'Grep method pattern:'
        self.input = 'VER.'

        update_choices
      end

      def draw_choice(choice)
        method, score = choice[:method], choice[:score]
        owner, name, parameters = method.owner, method.name, method.parameters

        params = []

        method.parameters.each do |param|
          case param.first
          when :req
            params << param.last
          when :opt
            params << "?#{param.last}"
          when :block
            params << "&#{param.last}"
          end
        end

        params = params.join(', ')

        window.puts " #{score} #{owner}.#{name}(#{params})"
      end

      def draw_selected_choice(choice)
        window.color = Color[:white, :blue]
        draw_choice(choice)
        window.color = Color[:white]
      end

      def pick
        @pick || @choices.first
      end

      # Intelligent method grepper, tries to find matching methods for a wide
      # range of input, by distributing scores.
      #
      # Possible input might be:
      #
      #   Window.y
      #   Window y
      #   Window::y
      #   Window#y
      #   VER y
      #   VER::View::File#copy
      #   VER::View::File.copy
      #   VER::View::File::copy
      #
      # The matching is very tolerant, so you can search for methods in
      # completely different namespaces but still get good results:
      #
      #   VER.delta
      #   # => VER::Buffer.apply_delta
      #   # => VER::Buffer.apply_deltas
      #   # => VER::Cursor.delta
      #
      #   sort
      #   # => VER::Cursor.boundary_sort
      #
      #   VER.ask
      #   # => #<Class:VER>.ask
      #   # => VER::View::File::Methods.buffer_ask
      #   # => VER::View::File::Methods.execute_ask
      #   # => VER::View::File::Methods.execute_ask_context
      #   # => VER::View::File::Methods.filter_selection_ask
      #   # => VER::View::File::Methods.goto_line_ask
      #   # => #<Class:FFI::NCurses>.mousemask
      #   # => VER::View::File::Methods.save_as_ask
      #   # => VER::View::File::Methods.search_ask
      #   # => VER::View::File::Methods.search_ask_context
      #
      # We are only using string comparisions to find matches, so input is
      # never interpreted as a regular expression and can include anything
      # without having to worry about special meaning within a regexp.
      #
      # There are some improvments possible (as usual).
      # In particular the scoring should become more accurate for short
      # methods, for example making adjustments when a method starts or ends
      # with the search string.
      def update_choices
        @pick = nil
        @choices = []

        needle = self.input.split(/::|[#.\s]+/)
        owner = needle.join('::')
        name = needle.last.to_s

        methods_of VER do |namespace, method|
          mnamespace = namespace.to_s
          mowner, mname = method.owner.to_s, method.name.to_s
          smowner = mowner.split('::')

          score = 0
          score += (needle & smowner).size
          if mname.include?(name)
            distance = Levenshtein.distance(mname, name)
            score += ([mname, name].max_by{|n| n.size }.size - distance)
          end

          next if score == 0

          @choices << {:namespace => namespace, :method => method, :score => score}
        end

        @choices = @choices.sort_by{|hash| [-hash[:score], hash[:method].name] }
      end

      def methods_of(namespace, seen = [], &block)
        return if seen.include?(namespace)
        seen << namespace

        if namespace.respond_to?(:instance_methods)
          namespace.instance_methods(false).each do |name|
            yield namespace, namespace.instance_method(name)
          end
        end

        if namespace.respond_to?(:singleton_methods)
          namespace.singleton_methods(false).each do |name|
            yield namespace, namespace.method(name)
          end
        end

        if namespace.respond_to?(:constants)
          namespace.constants.each do |name|
            methods_of(namespace.const_get(name), seen, &block)
          end
        end

        nil
      end
    end
  end
end
