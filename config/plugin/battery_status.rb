module VER
  class BatteryStatus
    # format sequences:
    #
    # %c Current capacity (mAh)
    # %r Current rate
    # %b short battery status, '+', '-', '!'
    # %p battery load percentage
    # %m remaining time in minutes
    # %h remaining time in hours
    # %t remaining time in as 'H:M'
    def to_s(format = '[%b] %p% %t')
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

battery_status = VER::BatteryStatus.new

VER.when_inactive_for 1000 do
  VER.buffers.each do |name, buffer|
    buffer.status.battery = battery_status.to_s
  end
end
