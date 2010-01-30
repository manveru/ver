module VER
  class ExceptionView < Tk::Tile::Treeview
    OPTIONS = {
      context: 7,
    }

    attr_reader :tree, :frames, :context_size, :error_tags, :backtrace_tags

    def initialize(parent, options = {})
      super

      @frames = {}
      @context_size = OPTIONS[:context]
      @error_tags = ['error']
      @backtrace_tags = ['backtrace']

      setup_config
      setup_binds
    end

    def setup_config
      configure(
        columns:        %w[line method],
        displaycolumns: %w[line method]
      )

      heading('#0',     text: 'File')
      heading('line',   text: 'Line')
      heading('method', text: 'Method')

      tag_configure('error', background: '#f88')
      tag_configure('backtrace', background: '#8f8')
    end

    def setup_binds
      bind('<<TreeviewOpen>>'){ on_treeview_open }

      bind('<Escape>'){
        pack_forget
        VER.buffers.values.first.focus
      }
    end

    def on_treeview_open
      item = focus_item
      frame = frames[item.id]

      case frame
      when Hash
        filename, lineno, first_lineno, context =
          frame.values_at(:filename, :lineno, :first_lineno, :context)

        context.each_with_index{|line, idx|
          line_lineno = first_lineno + idx + 1
          tags = line_lineno == lineno ? error_tags : backtrace_tags
          line_item = item.insert(:end,
            text: line, values: [line_lineno], tags: tags)
          frames[line_item.id] = [filename, lineno]
        }
      when Array
        filename, lineno = frame
        VER.find_or_create_buffer(filename, lineno){|buffer|
          pack_forget
        }
      end
    rescue => ex # careful here, don't want infinite loop
      puts ex, ex.backtrace
    end

    def show(exception)
      clear

      # from Rack::ShowExceptions
      exception.backtrace.each do |line|
        next unless line =~ /(.*?):(\d+)(:in `(.*)')?/
        show_line($1, $2.to_i, $4)
      end

      focus
      pack expand: true, fill: :both
    end

    def show_line(filename, lineno, function)
      item = insert(nil, :end,
        text: filename, values: [lineno, function], tags: error_tags)

      # may fail from here on without issues.
      lines = ::File.readlines(filename)
      _lineno = lineno - 1

      first_lineno = [_lineno - context_size, 0].max
      last_lineno  = [_lineno + context_size, lines.size].min
      context = lines[first_lineno..last_lineno]

      frames[item.id] = {
        filename: filename,
        lineno: lineno,
        function: function,
        first_lineno: first_lineno,
        last_lineno: last_lineno,
        context: context,
      }
    rescue => ex
      puts ex, ex.backtrace
    end
  end
end
