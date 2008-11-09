module VER
  module Syntax
    class Ruby
      attr_reader :matches, :syntax, :name

      def initialize
        @matches = []
        @syntax = []
        @name = 'Ruby'
      end

      KEYWORDS = %w[ alias begin class def do else elsif end ensure if unless module
      rescue return super until while true false __FILE__ __LINE__ ]

      # TODO: make this a lot more performant.
      def compile
        keywords = /\b#{Regexp.union(*KEYWORDS)}\b/
        let :yellow,  keywords
        let :magenta, /::[A-Z]\w+/     # ::AbsoluteConstant
        let :magenta, /[A-Z]\w+/       # RelativeConstant
        let :blue,    /\$\w+/          # $global_variable
        let :blue,    /@?@\w+/         # @instance_var and @@class_var
        let :white,   /(\.|::)[a-z]\w+/ # methods
        let :blue,    /:(@|@@|\$)?\w+/           # :symbol
        let :red,     /(['"])([^\1]*?)\1/ # 'string' and "string"
        let :red,     /%w\[[^\]]*\]/m  # %w[array]
#         let :magenta, /(^\s*|,\s*|\(\s*)\/[^\/]*\//     # /regexp/
        let :green,   /#.*$/           # comment
      end

      def let(color, regex)
        @syntax << [Color[color], regex]
      end

      def parse(buffer, range)
        compile if @syntax.empty?

        @matches.clear

        from = range.begin
        scanner = buffer.to_scanner(range)

        until scanner.eos?
          spos = scanner.pos

          @syntax.each do |color, regex|
            if match = scanner.scan(regex)
              pos = from + (scanner.pos - match.size)
              mark = from + scanner.pos

              cursor = buffer.new_cursor(pos, mark)
              cursor.color = color
              @matches << cursor
            end
          end

          # nothing matches here, go forward one character
          scanner.scan(/./um) if spos == scanner.pos
        end

        return @matches
      end
    end
  end
end
