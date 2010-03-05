require 'pathname'

# annoying fixes
class Pathname
  GUESS_ENCODING_ORDER = [
    Encoding::US_ASCII,
    Encoding::UTF_8,
    Encoding::Shift_JIS,
    Encoding::EUC_JP,
    Encoding::EucJP_ms,
    Encoding::Big5,
    Encoding::UTF_16BE,
    Encoding::UTF_16LE,
    Encoding::UTF_32BE,
    Encoding::UTF_32LE,
    Encoding::CP949,
    Encoding::Emacs_Mule,
    Encoding::EUC_KR,
    Encoding::EUC_TW,
    Encoding::GB18030,
    Encoding::GBK,
    Encoding::Stateless_ISO_2022_JP,
    Encoding::CP51932,
    Encoding::EUC_CN,
    Encoding::GB12345,
    Encoding::Windows_31J,
    Encoding::MacJapanese,
    Encoding::UTF8_MAC,
    Encoding::BINARY,
  ]

  alias / join

  def cp(dest)
    FileUtils.copy_file(expand_path.to_s, dest.to_s, preserve = true)
  end

  def =~(regexp)
    to_s =~ regexp
  end

  def glob(&block)
    if block
      Dir.glob(to_s){|match| yield(self.class.new(match)) }
    else
      Dir.glob(to_s)
    end
  end

  def shellescape
    to_s.shellescape
  end

  def read_encoded_file
    File.open(to_s, 'r:BINARY') do |io|
      begin
        require 'ver/vendor/open3'
        out, status = Open3.capture2('rchardet', stdin_data: io.read, binmode: true)
        encoding = out.strip
        io.rewind
        io.set_encoding(encoding)
        return io.read, io.external_encoding
      rescue Errno::ENOENT # rchardet missing?
        binary = io.read
        GUESS_ENCODING_ORDER.find{|enc|
          binary.force_encoding(enc)
          binary.valid_encoding?
        }
        return binary
      end
    end
  end
end
