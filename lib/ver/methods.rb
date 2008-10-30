module VER
  module Methods
    def self.add(mod, file = nil)
      file ||= mod.to_s.downcase
      autoload mod, "ver/methods/#{file}"
    end

    %w[ Ask Buffer Doc Control File Help Insert Movement Search Selection
    Status Switch ].each{|name| add(name) }

    add :AskFuzzyFile, :ask_fuzzy_file
    add :AskFile, :ask_file
    add :AskGrep, :ask_grep
  end
end
