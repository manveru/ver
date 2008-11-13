module VER
  module Syntax
    class Ruby < Common
      KEYWORDS = %w[ end def do if class nil and self for module in true return
                     when else false or not unless then begin case rescue yield
                     elsif super alias defined next while ensure END break
                     until undef retry BEGIN redo ]

      def spec
        region :ruby_string, /'/, /'/
        region :ruby_string, /"/, /"/
        region :ruby_comment, /#/, :eol

        match :ruby_symbol,             /:\w+/
        match :ruby_class_variable,     /@@\w+/
        match :ruby_instance_variable,  /@\w+/
        match :ruby_global_variable,    /\$\w+/
        match :ruby_keyword,            /\b(#{Regexp.union(KEYWORDS)})\b/

        highlights({
          :ruby_string => :string,
          :ruby_keyword => :identifier,
          :ruby_instance_variable => :identifier,
          :ruby_class_variable => :identifier,
          :ruby_global_variable => :identifier,
          :ruby_symbol => :identifier,
          :ruby_comment => :comment,
        })
      end
    end
  end
end

=begin
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
=end

