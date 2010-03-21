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
  alias rm unlink

  def rm_f
    rm
  rescue Errno::ENOENT
  rescue => ex
    VER.error(ex)
  end

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

  def self.tmpdir
    new(Dir.tmpdir)
  end

  def readonly?
    if file?
      if writable?
        false
      else
        true
      end
    else
      false
    end
  end

  def read_encoded_file
    content = read
    content.force_encoding('BINARY')

    require 'ver/vendor/open3'
    encoding, status = Open3.capture2('rchardet', to_s)
    content.force_encoding(encoding.strip)

    return content, content.encoding
  rescue ArgumentError, Errno::ENOENT # file or rchardet missing?
    if content
      GUESS_ENCODING_ORDER.find{|enc|
        content.force_encoding(enc)
        content.valid_encoding?
      }

      return content, content.encoding
    else
      return '', Encoding::UTF_8
    end
  end
end
