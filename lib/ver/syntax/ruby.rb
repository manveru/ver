module VER
  module Syntax
    class Ruby
      attr_reader :matches, :syntax, :name

      def initialize
        @matches = []
        @syntax = []
        @name = 'Ruby'
      end

      KEYWORDS = %w[ alias begin class def do else end ensure if unless
                       module rescue return super until while true false ]

      def compile
        keywords = /(^|\s)#{Regexp.union(*KEYWORDS)}($|\s)/
        let :yellow,  keywords
        let :red,     /"[^"]*"/     # "string"
        let :red,     /'[^']*'/     # 'string'
        let :magenta, /::[A-Z]\w+/  # ::AbsoluteConstant
        let :magenta, /[A-Z]\w+/    # RelativeConstant
        let :blue,    /\$\w+/       # $global_variable
        let :blue,    /@?@\w+/      # @instance_var and @@class_var
        let :blue,    /:\w+/        # :symbol
        let :green,   /#.*$/        # comment
      end

      def let(color, regex)
        @syntax << [Color[color], regex]
      end

      def parse(buffer)
        compile if @syntax.empty?
        @matches.clear

        @syntax.each do |color, matcher|
          if cursors = buffer.grep_cursors(matcher)
            @matches << [color, cursors]
          end
        end

        return @matches
      end
    end
  end
end
