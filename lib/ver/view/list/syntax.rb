module VER
  class View::List::Syntax < View::List
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