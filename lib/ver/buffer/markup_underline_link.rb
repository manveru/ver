module VER
  class Buffer
    class MarkupUnderlineLink < Tag
      NAME = 'markup.underline.link'.freeze

      def initialize(buffer, name = NAME)
        super

        configure underline: true, foreground: '#0ff'
        bind('<1>') do |event|
          current = buffer.index('current')
          uri = ranges.find{|range|
            next unless range.first <= current && range.last >= current
            range.get
          }

          if uri
            browser = ENV['BROWSER'] || ['links', '-g']
            system(*browser, uri)
            VER.message "Opening %p in %p" % [uri, browser]
          end
        end
      end

      def refresh(options = {})
        buffer.tag_all_matching(self, /https?:\/\/[^<>)\]}\s'"]+/, options)
      end
    end
  end
end
