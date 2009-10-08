module VER
  class ThemeListView < ListView
    def initialize(*args, &callback)
      super

      @callback = callback
      update
    end

    def update
      value = entry.value

      if value == value.downcase
        selected = themes.select{|buffer| buffer.downcase.include?(value) }
      else
        selected = themes.select{|buffer| buffer.include?(value) }
      end

      list.delete 0, :end
      list.insert :end, *selected
    end

    def themes
      Theme.list.map do |fullpath|
        File.basename(fullpath, File.extname(fullpath))
      end
    end
  end
end