require 'thread'
require 'strscan'
require 'pty'

class VER::Buffer::Terminal
  def initialize(parent)
    @parent = parent
    setup_widgets
    pty
  end

  def bench(name, &block)
    require 'benchmark'
    p name => Benchmark.realtime(&block)
  end

  def setup_widgets
    Tk.set_palette('black') # maybe use themes instead?

    @option_cache ||= {}
    @font ||= VER.options[:font]
    @font_actual ||= @font.actual_hash

    @text = Tk::Text.new(font: @font, insertofftime: 1)
    @text.pack expand: true, fill: :both
    @text.focus

    @text.bind('<Key>'){|event|
      @pty_queue << event.unicode
      Tk.callback_break
    }

    @text.bind('<Return>'){|event|
      @pty_queue << event.unicode
      # Tk.callback_break
    }
  end

  def destroy
    @text.destroy
  rescue Errno::EIO, PTY::ChildExited
  ensure
    @parent.focus
  end

  def pty
    @pty_queue = queue = Queue.new

    Thread.new do
      shell = ENV['SHELL'] || 'bash'

      PTY.spawn(shell) do |r_pty, w_pty, pid|
        Thread.new do
          while chunk = queue.shift
            w_pty.print chunk
            w_pty.flush
          end
        end

        begin
          loop do
            c = r_pty.sysread(1 << 15)
            on_chunk(c) if c
          end
        rescue Errno::EIO, PTY::ChildExited
          destroy
        end
      end
    end
  rescue Errno::EIO, PTY::ChildExited
    destroy
  end

  ANSI_CODES = []
  ANSI_CODES[0]  = :reset
  ANSI_CODES[1]  = :bold
  ANSI_CODES[2]  = :dark
  ANSI_CODES[3]  = :italic
  ANSI_CODES[4]  = :underline
  ANSI_CODES[5]  = :blink
  ANSI_CODES[6]  = :rapid_blink
  ANSI_CODES[7]  = :reverse
  ANSI_CODES[8]  = :concealed
  ANSI_CODES[9]  = :strikethrough
  ANSI_CODES[30] = :black
  ANSI_CODES[31] = :red
  ANSI_CODES[32] = :green
  ANSI_CODES[33] = :yellow
  ANSI_CODES[34] = :blue
  ANSI_CODES[35] = :magenta
  ANSI_CODES[36] = :cyan
  ANSI_CODES[37] = :white
  ANSI_CODES[40] = :on_black
  ANSI_CODES[41] = :on_red
  ANSI_CODES[42] = :on_green
  ANSI_CODES[43] = :on_yellow
  ANSI_CODES[44] = :on_blue
  ANSI_CODES[45] = :on_magenta
  ANSI_CODES[46] = :on_cyan
  ANSI_CODES[47] = :on_white

  # Trying to build a little dictionary of escape sequences:
  #
  # | Sequence       | Meaning         |
  # | \e]0;          | reset fg/bg     |
  # | \e[?1034h      | ???             |
  # | \e[01;34mbin\e | fg: 1, bg: 34   |

  def on_chunk(chunk)
    @buffer ||= ''
    @buffer << chunk
    s = StringScanner.new(@buffer)

    until s.eos?
      pos = s.pos

      case s.peek(1)
      when "\e"
        if    s.scan(/\e\](\d+);/)
          color s[1]
        elsif s.scan(/\e\[(\d+)([A-Z])/)
          color s[1]
        elsif s.scan(/\e\[\?(\d+h)/)
          color s[1]
        elsif s.scan(/\e\[(\d+);(\d+)m/) # \e[01;34m
          color s[1], s[2]
        elsif s.scan(/\e\[(\d+)[m;]/)
          color s[1]
        elsif s.scan(/\e\[([A-Z])/)
          color s[1]
        elsif s.scan(/\e\[m/)
          # nothing?
        elsif s.scan(/\e=\r/)
          delete 'insert linestart', 'insert lineend'
        else
          p s.rest
        end
      when "\r"
        if s.scan(/\r\n/)
          insert :end, "\n"
        elsif s.scan(/\r\r/)
          delete 'insert linestart', 'insert lineend'
        elsif s.scan(/\r[^\n\r]/)
          p :no_rn => s.matched
        else
          p :r_fail => s.rest
        end
      when "\x07"
        s.pos += 1
        delete 'insert linestart', 'insert lineend'
      when "\x08"
        s.pos += 1
        delete 'insert - 1 chars'
      else
        if s.scan(/\A[^\e\r\x08\x07]+/)
          insert :end, s.matched
        end
      end
     #  p s.matched

      if s.pos == pos
        warn("Scanner stopped at: %p" % [s])
        @buffer = s.rest
        return
      end
    end

    @buffer = ''
    @text.see :end
  rescue StringScanner::Error => ex
    VER.error(ex)
  rescue => ex
    puts "#{ex.class}: #{ex}", *ex.backtrace
    @buffer = ''
    destroy
  end

  def color(fg, bg = nil)
    if bg
      fg, bg = ANSI_CODES[fg.to_i], ANSI_CODES[bg.to_i]

      @tag = [:ansi, fg, bg].join('_')
      @text.tag_configure @tag, options_for(@tag, fg, bg)
    else
      fg = ANSI_CODES[fg.to_i]

      @tag = [:ansi, fg].join('_')
      @text.tag_configure @tag, options_for(@tag, fg)
    end
  end

  FG_COLORS = [:black, :red, :green, :yellow, :blue, :magenta, :cyan, :white]
  BG_COLORS = [:on_black, :on_red, :on_green, :on_yellow, :on_blue, :on_magenta, :on_cyan, :on_white]

  def options_for(tag, fg, bg = nil)

    if found = @option_cache[tag]
      return found
    end

    options = {}

    case fg
    when nil
    when :reset
      options[:font] = @font
      options[:background] = nil
      options[:foreground] = nil
    when :bold
      options[:font] = font_for(@font_actual.merge(weight: :bold))
    when *FG_COLORS
      options[:foreground] = fg
    when *BG_COLORS
      options[:background] = bg.to_s.sub(/on_/, '')
    else
      p fg: fg
    end

    case bg
    when nil
    when :reset
      options[:font] = @font
      options[:background] = nil
      options[:foreground] = nil
    when *FG_COLORS
      options[:foreground] = bg
    when *BG_COLORS
      options[:background] = bg.to_s.sub(/on_/, '')
    else
      p bg: bg
    end

    @option_cache[options] = options
    options
  end

  def font_for(options)
    @fonts ||= {}
    @fonts[options] ||= Tk::Font.new(options)
  end

  def ansi2sym(ansi)
    COLORS[ansi.to_i]
  end

  def insert(index, chars)
    # p insert: [index, chars]
    @text.insert(index, chars, @tag)
  end

  def delete(*indices)
    # p delete: indices
    @text.delete(*indices)
  end
end
