module VER
  class View
    class Console
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
        @text.tag_configure :input,  foreground: 'green', background: 'black'
        @text.tag_configure :output, foreground: 'white', background: 'black'
        @text.tag_configure :error,  foreground: 'red',   background: 'black'

        @entry = Tk::Tile::Entry.new(@parent)
        @entry.pack fill: :x, side: :bottom
        @text.pack fill: :both, side: :bottom, after: @entry, expand: true
      end

      def setup_events
        @entry.bind('Control-q'){ Tk.exit }
        @entry.bind('Return'){
          @buffer << @entry.value
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

        @thread = Thread.new{
          Open3.popen3(*opts) do |write, read, error, popen_thread|
            catch(:stop) do
              loop do
                # that's where the PID of the console hides
                # p Hash[popen_thread.keys.map{|k| [k, popen_thread[k]] }]
                step(write, read, error)
                sleep 0.1
              end
            end

            destroy
          end
        }
      end

      def step(write, read, error)
        r, w, e = IO.select([read], [write], [error], 1)

        if w && w.size > 0
          while line = @buffer.shift
            on_stdin line
            w.map{|io| io.puts(line) }
          end
        end

        read_nonblock(e){|line| on_stderr(line) }
        read_nonblock(r){|line| on_stdout(line) }

      rescue Errno::EPIPE, EOFError
        throw :stop
      rescue Exception => ex
        VER.error(ex)
        throw :stop
      end

      def read_nonblock(ios)
        if ios && ios.size > 0
          begin
            results = ios.map{|io| io.read_nonblock(2 << 15) }
            results.each do |result|
              result.each_line do |line|
                yield line
              end
            end
          rescue IO::WaitReadable, Errno::EINTR => ex
            # the IO isn't ready yet, just go back to work
          end
        end
      end

      def on_stdin(string)
        output "i> #{string}\n", :input # bg: 'black', fg: 'green'
      end

      def on_stdout(string)
        output "#{string}", :output, # bg: 'black', fg: 'white'
      end

      def on_stderr(string)
        output "e> #{string}", :error # bg: 'black', fg: 'red'
      end

      def output(string, tag)
        @text.insert(:end, string, tag)
        @text.see(:end)
      end
    end
  end
end