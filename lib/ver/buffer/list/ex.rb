module VER
  class Buffer::List::Ex < Buffer::List
    def initialize(parent, filter, &callback)
      @filter = filter
      @previous = ''
      @propose = nil
      super(parent, &callback)
    end

    def update
      value = entry.value

      if value =~ /\s/
        completion
      else
        list.value = @filter.call(value)
      end
    end

    def pick_selection
      if @propose
        pick_action(@command, @propose)
      else
        pick_action(entry.value)
      end

      destroy
    end

    def completion
      value = entry.value
      command, arg = value.split(' ', 2)
      complete_command(command, arg)
    end

    def complete_command(command, arg)
      name = "complete_#{command}"

      if respond_to?(name)
        possible = send(name, arg)
        list.value = possible
        completed = complete_arg(arg, possible)
        @command, @propose = command, completed
        entry.value = "#{command} #{completed}"
      end
    end

    def complete_arg(arg, possible)
      case possible.size
      when 0
        return arg
      when 1
        return possible.first
      else
        require 'abbrev'
        abbrev = possible.abbrev

        if found = abbrev[arg]
          return found
        else
          return abbrev.keys.sort_by{|k| k.size }.first[0..-2]
        end
      end
    end

    def complete_e(value)
      Dir["#{value}*"].map{|f| File.directory?(f) ? "#{f}/" : f }
    end
    alias complete_o complete_e
  end
end
