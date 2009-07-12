module VER
  class View
    class Doc < View
      module Methods
        def show_doc
          return unless string = cursor.current_line.strip
          return unless found = view.list.assoc(string)
          return unless method = found[1]

          VER.warn string
          VER.warn method
          VER.warn method.source_location
          VER.warn method.parameters
        end
      end

      LAYOUT = {
        :width => lambda{|w| w },
        :height => lambda{|h| h },
        :top => 0,
        :left => 0
      }

      DEFAULT = {
        :interactive => true,
        :mode => :doc,
      }

      attr_reader :list

      def initialize(*args)
        super

        buffer_name = self.class.name.split('::').last.downcase.to_sym
        @buffer = MemoryBuffer.new(buffer_name)
      end

      def open(regexp)
        @list = methods_of(VER)

        @list.each do |string, meta|
          buffer << "#{string}\n"
        end

        super()
      end

      def draw
        pos = adjust_pos
        y = 0

        visible_each do |line|
          window.move(y, 0)
          window.print line
          y += 1
        end

        window.move(*pos) if pos
      end

      def methods_of(namespace, seen = [])
        methods = []
        return methods if seen.include?(namespace)
        seen << namespace

        if namespace.respond_to?(:instance_methods)
          namespace.instance_methods(false).each do |name|
            method = namespace.instance_method(name)
            string = "#{namespace}##{name}"
            methods << [string, method]
          end
        end

        if namespace.respond_to?(:singleton_methods)
          namespace.singleton_methods(false).each do |name|
            method = namespace.method(name)
            string = "#{namespace}::#{name}"
            methods << [string, method]
          end
        end

        if namespace.respond_to?(:constants)
          namespace.constants.each do |name|
            methods += methods_of(namespace.const_get(name), seen)
          end
        end

        methods
      end
    end
  end
end
