require 'ver/methods/doc'

module VER
  class DocView < MainView
    METHODS = [Methods::Main, Methods::Doc]
    INITIAL_MODE = :doc

    def show(regexp)
      found = query(regexp)
      file, name, doc = found.first

      text = "#{file} : #{name} : #{doc * "\n"}"

      buffer[0..-1] = text
    end

    def show_doc(file, method, doc)
      text = "#{file} : #{name} : #{doc * "\n"}"
      buffer[0..-1] = text
      draw
    end

    def query(regexp)
      docs = parse_docs

      found = []

      docs.each do |file, methods|
        methods.each do |name, doc|
          found << [file, name, doc]
        end
      end

      return found
    end

    def parse_docs
      @docs = {}
      doc = []

      glob = File.join(DIR, 'ver/methods/*.rb')

      Dir[glob].each do |file|
        current = @docs[file] = {}

        File.open(file) do |io|
          while line = io.gets
            case line
            when /^\s*#(.*)/
              doc << $1.strip
            when /^\s*def\s*(\w+)/
              current[$1] = doc
              doc = []
            end
          end
        end
      end

      return @docs
    end

    def draw
      super
    ensure
      window.refresh
    end

    def activate
      window.show
      window.color_set Color[:white]
      draw
      focus_input
    end

    def deactivate
      window.hide
    end
  end
end

