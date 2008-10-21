module VER
  class FileBuffer < MemoryBuffer
    attr_reader :filename, :cursor

    def initialize(name, file_or_filename)
      super(name)
      @cursor = new_cursor(0)

      case file_or_filename
      when File
        load_file(file_or_filename)
      when String
        load_filename(file_or_filename)
      else
        raise ArgumentError, "Not a File or String: %p" % file_or_filename
      end
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
        @data = ''
        @dirty = true
      end
    end

    def save_file
      File.open(filename, 'w+') do |file|
        file.puts @data
      end

      @dirty = false
      return filename
    end

    def hash
      filename
    end

    def eql?(other)
      filename == other.filename
    end
  end
end
