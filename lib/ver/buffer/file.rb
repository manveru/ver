module VER
  class FileBuffer < MemoryBuffer
    attr_reader :filename, :scratch

    def initialize(name, file_or_filename, scratch = false)
      super(name)
      @scratch = scratch

      if scratch
        initialize_scratch
      else
        initialize_file(file_or_filename)
      end
    end

    def scratch?
      @scratch
    end

    def initialize_scratch
      @data = ''
      @scratch = @dirty = true
      @modified = false
    end

    # TODO: make this bulletproof
    def guess_eol
      @eol = @data.scan(/\n|\r\n|\r/).first
    end

    def initialize_file(file_or_filename)
      case file_or_filename
      when File
        load_file(file_or_filename)
      when String
        load_filename(file_or_filename)
      else
        raise ArgumentError, "Not a File or String: %p" % file_or_filename
      end

      guess_eol

      @data.gsub!(/#{@eol}/, "\n") unless @eol == "\n"
    end

    # TODO: should it close?
    def load_file(file)
      file.rewind
      @data = file.read
      @filename = file.path
    end

    def load_filename(file)
      @filename = File.expand_path(file)

      if File.file?(@filename)
        @data = File.read(@filename)
      else
        initialize_scratch
      end
    end

    def save_file(filename = filename)
      File.open(filename, 'w+') do |file|
        file.puts @data.gsub("\n", @eol)
      end

      @scratch = @modified = @dirty = false
      @filename = filename
    end

    def short_filename
      home = Regexp.escape(::File.expand_path('~/'))
      filename.to_s.gsub(/^#{Dir.pwd}\//, './').gsub(/^#{home}\//, '~/')
    end

    def hash
      filename
    end

    def eql?(other)
      filename == other.filename
    end
  end
end
