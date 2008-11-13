module VER
  module Syntax
    class Haml < Common
      def compile
        region :haml_line_tag, :start => /^\s*%[\w:-]+/, :end => /$/, :oneline, :keepend
        match
      end
    end
  end
end
