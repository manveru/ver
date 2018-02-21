module VER
  class Buffer
    class MarkupUnderlineLink < Tag
      NAME = 'markup.underline.link'

      def initialize(buffer, name = NAME)
        super

        configure underline: true, foreground: '#0ff'
        bind('<1>') do |_event|
          current = buffer.index('current')
          uri = ranges.find do |range|
            next unless range.first <= current && range.last >= current
            range.get
          end

          if uri
            browser = buffer.options.http_browser
            system(*browser, uri)
            buffer.message format('Opening %p in %p', uri, browser)
          end
        end
      end

      def refresh(options = {})
        buffer.tag_all_matching(self, /https?:\/\/[^<>)\]}\s'"]+/, options)
      end
    end
  end
end
