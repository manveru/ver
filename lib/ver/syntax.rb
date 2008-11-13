module VER
  module Syntax
    EXT_NAME = {}

    def self.register(name, *extensions)
      autoload name, "ver/syntax/#{name}".downcase
      extensions.each{|ext| EXT_NAME[ext] = name }
    end

    def self.from_filename(filename)
      return unless filename.respond_to?(:to_str)

      base = File.basename(filename.to_str)

      EXT_NAME.each do |ext, name|
        return const_get(name).new(name) if base =~ ext
      end

      return nil
    end

    register :Ruby, /\.rb$/, /^rakefile(\.rb)?$/i
    register :Haml, /\.haml$/
    register :Markdown, /\.mk?d/, /\.markdown/i

    class Common
      attr_reader :matches, :syntax, :name

      def initialize(name)
        @name = name.to_s

        @syntax = {
          :matches => [],
          :regions => [],
        }

        @matches = []
        @compiled = false
      end

      def let(color, regex)
        @syntax << [Color[color], regex]
      end

      def region(name, from, to, options = {})
        @syntax[:regions] << [name, from, to, options]
      end

      def match(name, regexp, options = {})
        @syntax[:matches] << [name, regexp, options]
      end

      def color(name)
        case @highlights[name] || name
        when :string
          Color[:blue]
        when :comment
          Color[68]
        when :identifier
          Color[:yellow]
        when :italic
          Color[:green]
        when :bold
          Color[:black, :white]
        else
          Color[:magenta]
        end
      end

      def parse(buffer, range)
        compile unless compiled?

        @matches.clear

        @from = range.begin
        @scanner = buffer.to_scanner(range)

        until @scanner.eos?
          pos = @scanner.pos
          step(buffer)
          @scanner.scan(/./um) if pos == @scanner.pos
        end

        @scanner = nil

        return @matches
      end

      def step(buffer)
        return unless found = step_regions || step_matches

        name, pos, mark = *found

        cursor = buffer.new_cursor(pos, mark)
        cursor.color = color(name)
        @matches << cursor
      end

      def step_matches
        @syntax[:matches].each do |m|
          found = step_match(*m)
          return found if found
        end

        return nil
      end

      def step_regions
        @syntax[:regions].each do |r|
          found = step_region(*r)
          return found if found
        end

        return nil
      end

      def step_region(name, from, to, options)
        return if options[:bol] and not @scanner.bol?

        debug = name == :mkd_blockquote
        to, backoff = /\n/, 1 if to == :eol

        if from_str = @scanner.scan(from)
          pos = @from + (@scanner.pos - from_str.size)

          if to_str = @scanner.scan_until(to)
            @scanner.pos -= backoff if backoff
            mark = @from + @scanner.pos

            return name, pos, mark
          end
        end

        return
      end

      def step_match(name, regexp, options)
        return if options[:bol] and not @scanner.bol?

        if str = @scanner.scan(regexp)
          pos = @from + (@scanner.pos - str.size)
          mark = @from + @scanner.pos

          return name, pos, mark
        end

        return
      end

      def highlights(hash)
        @highlights = hash
      end

      def compile
        spec
        @compiled = true
      end

      def compiled?
        @compiled
      end
    end
  end
end
