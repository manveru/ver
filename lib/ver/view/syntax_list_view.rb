module VER
  class SyntaxListView < ListView
    def update
      list.value = sublist(syntaxes)
    end

    def syntaxes
      Syntax.list.map do |fullpath|
        File.basename(fullpath, File.extname(fullpath))
      end
    end
  end
end