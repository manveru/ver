module VER
  class Syntax
    class Specification < Struct.new(
    	:comment,
    	:file_types,
    	:filename,
    	:first_line_match,
    	:folding_start_marker,
    	:folding_stop_marker,
    	:key_equivalent,
    	:name,
    	:patterns,
    	:repository,
    	:scope_name,
    	:uuid )

      def initialize(filename)
        self.filename = filename
        parse
      end

      def parse
        content = JSON.load(File.read(filename))
        content.each do |key, value|
          send("#{key}=", value)
        end
      end

      def patterns=(patterns)
        self[:patterns] = patterns.map{|pattern| Pattern.new(pattern) }
      end

      def each_line_pattern
        patterns.each do |pattern|
          yield pattern if pattern.match
        end
      end

      def each_block_pattern
        patterns.each do |pattern|
          yield pattern if pattern.begin
        end
      end

      alias fileTypes= file_types=
      alias firstLineMatch= first_line_match=
      alias foldingStartMarker= folding_start_marker=
      alias foldingStopMarker= folding_stop_marker=
      alias keyEquivalent= key_equivalent=
      alias scopeName= scope_name=
    end
  end
end