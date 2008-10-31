module VER
  module Syntax
    class Ruby
      attr_reader :matches, :syntax, :name

      def initialize
        @matches = []
        @syntax = []
        @name = 'Ruby'
      end

      KEYWORDS = %w[ alias begin class def do else end ensure if unless module
      rescue return super until while true false __FILE__ __LINE__ ]

      def compile
        keywords = /\b#{Regexp.union(*KEYWORDS)}\b/
        let :yellow,  keywords
#         let :magenta, /::[A-Z]\w+/  # ::AbsoluteConstant
#         let :magenta, /[A-Z]\w+/    # RelativeConstant
#         let :blue,    /\$\w+/       # $global_variable
#         let :blue,    /@?@\w+/      # @instance_var and @@class_var
#         let :blue,    /:\w+/        # :symbol
#         let :red,     /'[^']*'/     # 'string'
#         let :red,     /"[^"]*"/     # "string"
#         let :red,     /%w\[[^\]]*\]/ # %w[array]
#         let :green,   /#.*$/        # comment
#         let :magenta, /\/[^\/]*\// # %w[array]
      end

      def let(color, regex)
        @syntax << [Color[color], regex]
      end

      def parse(buffer)
        compile if @syntax.empty?
        @matches.clear

        # scanner = StringScanner.new(string)
        @syntax.each do |color, matcher|
          cursors = buffer.grep_cursors(matcher)
          cursors.each{|c| c.color = color }
          @matches += cursors
        end

        return @matches
      end
    end
  end
end
