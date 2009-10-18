module VER
  class Syntax
    class Pattern < Struct.new(:begin, :begin_captures, :captures, :comment,
                               :content_name, :end, :end_captures, :match, :name,
                               :patterns, :include)

      def initialize(pattern)
        pattern.each do |key, value|
          send("#{key}=", value)
        end
      end

      def match=(value)
        self[:match] = Regexp.new(value)
      end

      def patterns=(patterns)
        self[:patterns] = patterns.map{|pattern| self.class.new(pattern) }
      end

      def captures=(captures)
        self[:captures] = sanitize_captures(captures)
      end

      def each_capture(&block)
        captures.each(&block) if captures
      end

      def begin_captures=(begin_captures)
        self[:begin_captures] = sanitize_captures(begin_captures)
      end

      def end_captures=(end_captures)
        self[:end_captures] = sanitize_captures(end_captures)
      end

      alias beginCaptures= begin_captures=
      alias endCaptures= end_captures=
      alias contentName= content_name=

      def sanitize_captures(captures)
        sanitized = {}

        captures.each do |capture|
          key, value = *capture
          if key =~ /^\d+$/
            sanitized[key.to_i] = value['name']
          else
            sanitized[key.to_sym] = value['name']
          end
        end

        sanitized
      end

      def inspect
        out = ["#<VER::Syntax::Pattern"]

        self.class.members.each do |name|
          value = self[name]
          out << "#{name}=%p" % [value] unless value.nil?
        end

        out.join('  ')
      end
    end
  end
end