module VER
  class Buffer::List::Theme < Buffer::List
    def update
      list.value = sublist(themes)
    end

    def themes
      VER::Theme.list.map do |fullpath|
        File.basename(fullpath, File.extname(fullpath))
      end
    end
  end
end