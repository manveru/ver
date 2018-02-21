module VER
  class Status
    class Battery < Tk::Canvas
      attr_reader :status, :weight, :format, :row, :column, :sticky

      def initialize(status, options = {})
        @status = status
        @weight = options.delete(:weight) || 0
        @format = options.delete(:format) || '[%b] %p% %t'
        @row = options.delete(:row)
        @column = options.delete(:column)
        @sticky = options.delete(:sticky)
        super

        @width = cget(:width)
        @height = cget(:height)

        draw_battery
        draw_text

        percent, string = Battery.update(format)
        show(percent / 100.0, string)

        @show_block = VER.when_inactive_for(5000) do
          percent, string = Battery.update(format)
          show(percent / 100.0, string)
        end

        tk_parent.bind '<Destroy>' do |_event|
          VER.cancel_block(@show_block)
        end
      end

      def style=(config)
        configure(background: config[:background])
      end

      def draw_battery
        # yay for scalable vector graphics
        @battery = create_polygon(
          0, 0,
          0, @height,
          @width * 0.95, @height,
          @width * 0.95, @height * 0.8,
          @width, @height * 0.8,
          @width, @height * 0.2,
          @width * 0.95, @height * 0.2,
          @width * 0.95, 0
        )
      end

      def draw_text
        @label = create_text(
          @width * 0.5,
          @height * 0.5,
          font: status.text.options[:font],
          anchor: 'center'
        )
      end

      def show(percent, string)
        r = 0xffff - (0xffff * percent)
        g = (0xffff * percent)
        b = 0
        color = format('#%04x%04x%04x', r, g, b)
        @battery.configure fill: color
        @label.configure text: string
      end

      def self.update(format)
        now = Time.now

        if @battery_last
          if @battery_last < (now - 60)
            @battery_last = now
            @battery_value = battery_build(format)
          else
            @battery_value
          end
        else
          @battery_last = now
          @battery_value = battery_build(format)
        end
      rescue StandardError => ex
        VER.error(ex)
        ex.message
      end

      def self.battery_build(format)
        total = {}

        Dir.glob('/proc/acpi/battery/*/{state,info}') do |file|
          parsed = battery_parse(file)
          next unless parsed[:present] == 'yes'
          # FIXME: doesn't take care of multiple batteries
          total.merge!(parsed)
        end

        # rate might be 0
        rate = total[:present_rate].to_i
        capacity = total[:remaining_capacity].to_i

        if rate == 0
          hours = 2
          percent = 100
          time = hours_left = minutes_left = 'N/A'
        else
          hours, minutes = ((capacity * 60.0) / rate).divmod(60)
          minutes = minutes.round
          percent = ((100 / total[:last_full_capacity].to_f) * capacity).round
          hours_left = (hours + (minutes / 60.0)).round
          minutes_left = (hours / 60.0) + minutes
          time = "#{hours}:#{minutes}"
        end

        case total[:charging_state]
        when 'discharging'
          b = hours < 1 ? '!' : '-'
        when 'charging'
          b = '+'
        end

        final = {
          '%c' => capacity,
          '%r' => rate,
          '%b' => b,
          '%p' => percent,
          '%m' => minutes_left,
          '%h' => hours_left,
          '%t' => time
        }

        @last = Time.now
        [percent, format.gsub(/%\w/, final)]
      end

      def self.battery_parse(file)
        data = {}

        File.open(file) do |io|
          io.each_line do |line|
            next unless line =~ /^([^:]+):\s*(.+)$/
            data[Regexp.last_match(1).downcase.tr(' ', '_').to_sym] = Regexp.last_match(2)
          end
        end

        data
      end
    end # Battery
  end # Status
end # VER
