require 'ver/vendor/levenshtein'

module VER
  # Show methods based on patterns.
  #
  # TODO: Handle C and evaled methods.
  #       Once 1.9.2 is out, use Method#parameters.
  class Buffer::List::Methods < Buffer::List
    def update
      list.value = update_choices.map{|choice|
        method, score = choice.values_at(:method, :score)
        " #{score} #{method.owner}.#{method.name}"
      }
    end

    def pick_action(entry)
      index = list.curselection.first
      choice = @choices[index]

      return unless method = choice[:method]

      if location = method.source_location
        filename, line = location

        if ::File.file?(filename)
          callback.call(filename, line)
        else
          # defined by clumsy eval
        end
      else
        # C method?
      end
    end

    def insert_choice(choice)
      method, score = choice.values_at(:method, :score)
      owner, name = method.owner, method.name

      list.insert :end, " #{score} #{owner}.#{name}"
      return

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

      list.insert :end, " #{score} #{owner}.#{name}(#{params})"
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
    #   VER::Buffer::File#copy
    #   VER::Buffer::File.copy
    #   VER::Buffer::File::copy
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
    #   # => VER::Buffer::File::Methods.buffer_ask
    #   # => VER::Buffer::File::Methods.execute_ask
    #   # => VER::Buffer::File::Methods.execute_ask_context
    #   # => VER::Buffer::File::Methods.filter_selection_ask
    #   # => VER::Buffer::File::Methods.goto_line_ask
    #   # => #<Class:FFI::NCurses>.mousemask
    #   # => VER::Buffer::File::Methods.save_as_ask
    #   # => VER::Buffer::File::Methods.search_ask
    #   # => VER::Buffer::File::Methods.search_ask_context
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
      @choices = []

      needle = entry.value.split(/::|[#.\s]+/)
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

        @choices << {namespace: namespace, method: method, score: score}
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
