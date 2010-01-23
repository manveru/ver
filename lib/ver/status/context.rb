module VER
  class Status
    class Context < Struct.new(:text)
      def filename(width = 0)
        "%#{width}s" % text.filename
      end
      alias F filename

      def basename(width = 0)
        "%#{width}s" % text.filename.basename
      end
      alias f basename

      def relative(width = 0)
        "%#{width}s" % text.short_filename
      end
      alias r relative

      def dir(width = 0)
        "%#{width}s" % text.filename.directory
      end
      alias d dir

      def line(width = 0)
        "%#{width}s" % (text.count(1.0, :insert, :lines) + 1)
      end
      alias l line

      def lines(width = 0)
        "%#{width}s" % text.count(1.0, :end, :lines)
      end
      alias L lines

      def column(width = 0)
        "%#{width}s" % text.count('insert linestart', :insert, :displaychars)
      end
      alias c column

      def percent
        here = text.count(1.0, :insert, :lines)
        total = text.count(1.0, :end, :lines)
        percent = ((100.0 / total) * here).round

        case percent
        when 100; 'Bot'
        when 0  ; 'Top'
        else    ; '%2d%%' % percent
        end
      end
      alias P percent

      def buffer(width = 0)
        "%#{width}s" % text.layout.views.index(text.view)
      end
      alias b buffer

      def buffers(width = 0)
        "%#{width}s" % text.layout.views.size
      end
      alias B buffers

      def encoding(width = 0)
        "%#{width}s" % text.encoding
      end
      alias e encoding

      def syntax(width = 0)
        "%#{width}s" % text.syntax.name if text.syntax
      end
      alias s syntax

      def mode(width = 0)
        "%#{width}s" % text.major_mode.name
      end
      alias m mode

      def nano(width = 0)
        line_now     = text.count(1.0, :insert, :lines) + 1
        line_total   = text.count(1.0, :end, :lines)
        line_percent = ((100.0 / line_total) * line_now)
        line_percent = 0 if line_percent.nan?

        col_now     = text.count('insert linestart', :insert, :chars) + 1
        col_total   = text.count('insert linestart', 'insert lineend', :chars) + 1
        col_percent = ((100.0 / col_total) * col_now)
        col_percent = 0 if col_percent.nan?

        char_now   = text.count(1.0, :insert, :chars)
        char_total = text.count(1.0, :end, :chars) - 1
        char_percent = ((100.0 / char_total) * char_now)
        char_percent = 0 if char_percent.nan?

        raw = "%d/%d (%d%%), %d/%d (%d%%), %d/%d (%d%%)" % [
          line_now, line_total, line_percent.round,
          col_now,  col_total,  col_percent.round,
          char_now, char_total, char_percent.round,
        ]
        "%#{width}s" % [raw]
      end

      # format sequences:
      #
      # %c Current capacity (mAh)
      # %r Current rate
      # %b short battery status, '+', '-', '!'
      # %p battery load percentage
      # %m remaining time in minutes
      # %h remaining time in hours
      # %t remaining time in as 'H:M'
      def battery(format = '[%b] %p% %t')
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
      rescue => ex
        puts ex, *ex.backtrace
        ex.message
      end

      def battery_build(format)
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
          hours, percent = 2, 100
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
          '%t' => time,
        }

        @last = Time.now
        format.gsub(/%\w/, final)
      end

      def battery_parse(file)
        data = {}

        File.open(file) do |io|
          io.each_line do |line|
            next unless line =~ /^([^:]+):\s*(.+)$/
            data[$1.downcase.tr(' ', '_').to_sym] = $2
          end
        end

        data
      end
    end
  end
end
