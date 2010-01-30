module VER
  class Buffer::List::Syntax < Buffer::List
    def update
      list.value = sublist(syntaxes)
    end

    def syntaxes
      VER::Syntax.list.map do |fullpath|
        File.basename(fullpath, File.extname(fullpath))
      end
    end
  end
end