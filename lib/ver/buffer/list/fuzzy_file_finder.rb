require 'ver/vendor/fuzzy_file_finder'

module VER
  class Buffer::List::FuzzyFileFinder < Buffer::List
    FFF = ::FuzzyFileFinder

    def fffinder
      @fffinder ||= FFF.new(Dir.pwd)
    rescue FFF::TooManyEntries
      message "The FuzzyFileFinder is overwhelmed by the amount of files"
      destroy
    end

    def update
      choices = fffinder.find(entry.value.chomp('/'))
      choices = choices.sort_by{|m| [-m[:score], m[:path]] }

      list.clear

      pwd = Dir.pwd + '/'
      choices.each do |choice|
        choice[:path].sub!(pwd, '')
        insert_choice(choice)
      end
    end

    def insert_choice(choice)
      path, score = choice.values_at(:path, :score)
      list.insert(:end, path)

      foreground, background =
        case score
        when 0          ; ['white',  'black']
        when 0   ..0.25 ; ['red',    'black']
        when 0.25..0.75 ; ['yellow', 'black']
        when 0.75..1    ; ['green',  'black']
        end

      list.itemconfigure(:end,
              foreground: foreground,       background: background,
        selectforeground: background, selectbackground: foreground)
    end
  end
end
