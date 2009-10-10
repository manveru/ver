module VER
  class ThemeListView < ListView
    def update
      list.value = sublist(themes)
    end

    def themes
      Theme.list.map do |fullpath|
        File.basename(fullpath, File.extname(fullpath))
      end
    end
  end
end