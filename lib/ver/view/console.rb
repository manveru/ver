module VER
  class View
    class Console
      class Process < EventMachine::Connection
        attr_accessor :callback

        def receive_data data
          callback.on_stdout(data)
        end

        def unbind
          callback.destroy
          EM.stop
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

      def initialize(parent)
        @parent = parent
        setup_widgets
        setup_events
        @entry.focus
        setup_terminal
      end

      def setup_widgets
        font = VER.options[:font]
        tab_width = font.measure('0') * 2

        @text = TkText.new(
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
        @entry.bind('Control-q'){ Tk.exit }
        @entry.bind('Return'){
          send_data @entry.value
          @entry.delete 0, :end
        }
      end

      def destroy
        @text.destroy
        @entry.destroy
        @parent.focus
      end

      def setup_terminal
        require 'open3'
        @buffer = []
        shell = ENV['SHELL'] || 'sh'
        opts = [shell]

        case shell
        when /zsh/
          opts << '-s'
          @buffer << 'echo $ZSH $ZSH_VERSION'
        when /bash/
          opts << '-s'
          @buffer << 'echo $BASH $BASH_VERSION'
        end

        # FIXME: this should have proper shell escapes
        popen3(opts.join(' '), self) do |stdin|
          begin
            @stdin = stdin

            while line = @buffer.shift
              send_data(line)
            end
          rescue => ex
            p ex
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