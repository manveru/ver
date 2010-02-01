# annoying fixes
class Pathname
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
end
