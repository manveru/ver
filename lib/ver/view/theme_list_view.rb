module VER
  class ThemeListView < ListView
    def update
      list.value = themes_for(entry.value)
    end

    def themes_for(name)
      if name == name.downcase
        themes.select{|theme| theme.downcase.include?(value) }
      else
        themes.select{|theme| theme.include?(value) }
      end
    end

    def themes
      Theme.list.map do |fullpath|
        File.basename(fullpath, File.extname(fullpath))
      end
    end
  end
end