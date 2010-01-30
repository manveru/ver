require 'eventmachine'

module VER
  class Buffer
    class Console
      class Process < EventMachine::Connection
        attr_accessor :callback

        def receive_data(data)
          callback.on_stdout(data)
        end

        def unbind
          callback.closed
        end
      end

      class Stderr < EventMachine::Connection
        attr_accessor :callback

        def initialize(stderr)
          @stderr = stderr
        end

        def receive_data(data)
          callback.on_stderr(data)
        end
      end

      def initialize(parent, *cmd)
        @parent = parent
        setup_widgets
        setup_events
        setup_terminal(*cmd)
      end

      def setup_widgets
        font = VER.options[:font]
        tab_width = font.measure('0') * 2

        @text = Tk::Text.new(
          @parent,
          borderwidth: 0,
          exportselection: true,
          font: font,
          insertofftime: 0,
          setgrid: true,
          tabs: tab_width,
          tabstyle: :wordprocessor,
          background: 'black',
          foreground: 'white',
          wrap: :word
        )
        @text.tag_configure :stdin,  foreground: 'green', background: 'black'
        @text.tag_configure :stdout, foreground: 'white', background: 'black'
        @text.tag_configure :stderr, foreground: 'red',   background: 'black'

        @entry = Tk::Tile::Entry.new(@parent)
        @entry.pack fill: :x, side: :bottom
        @text.pack fill: :both, side: :bottom, after: @entry, expand: true
      end

      def setup_events
        @entry.bind('<Control-q>'){ Tk.exit }
        # @entry.bind('Escape'){ closed }
        @entry.bind('<Return>'){
          send_data @entry.value
          @entry.clear
        }
      end

      def closed
        @entry.bind('<Return>'){}
        @entry.bind('<Key>'){ Tk.callback_break }
        @entry.bind('<Escape>'){ destroy }
        @entry.value = 'Session ended. Press Escape to close console'
      rescue => ex
        VER.error(ex)
      end

      def destroy
        @text.destroy
        @entry.destroy
        @parent.focus
      end

      def shell_config
        buffer = []

        shell = ENV['SHELL'] || 'sh'
        opts = [shell]

        case shell
        when /zsh/
          opts << '-s'
          buffer << 'echo $ZSH $ZSH_VERSION'
        when /bash/
          opts << '-s'
          buffer << 'echo $BASH $BASH_VERSION'
        end

        return buffer, opts
      end

      def setup_terminal(*cmd)
        if cmd.empty?
          @buffer, opts = shell_config
        else
          @buffer = []
          opts = cmd
        end

        # FIXME: this should have proper shell escapes
        popen3(opts.join(' '), self) do |stdin|
          begin
            @entry.focus
            @stdin = stdin

            while line = @buffer.shift
              send_data(line)
            end
          rescue => ex
            VER.error(ex)
          end
        end
      end

      # the callback should have #on_stdout and #on_stderr
      # The method yields the stdin and you can use #send_data on it.
      # This seems to have the side-effect of messing with the original $stderr,
      # maybe there are other solutions.
      def popen3(cmd, callback)
        old_stderr = $stderr.dup
        rd, wr = IO::pipe
        $stderr.reopen(wr)

        popen_stdin = EM.popen(cmd, Process)
        popen_stdin.callback = callback

        popen_stderr = EM.attach(rd, Stderr, rd)
        popen_stderr.callback = callback

        yield(popen_stdin) if block_given?

        $stderr.reopen old_stderr
      end

      def send_data(string)
        @stdin.send_data("#{string}\n")
        on_stdin(string)
      end

      def on_stdin(string)
        output "i> #{string}\n", :stdin
      end

      def on_stdout(string)
        output "#{string}", :stdout
      end

      def on_stderr(string)
        output "e> #{string}", :stderr
      end

      def output(string, tag)
        @text.insert(:end, string, tag)
        @text.see(:end)
      end
    end
  end
end
