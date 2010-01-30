module VER
  class Buffer::List::Grep < Buffer::List
    def initialize(parent, glob = nil, &block)
      super(parent, &block)

      @glob = nil
      @glob = glob.to_s unless glob.nil?
    end

    def update
      list.clear

      grep(entry.value).each do |choice|
        list.insert(:end, "#{choice[:match]} -- #{choice[:file]} +#{choice[:line]}")
      end
    end

    def pick_action(entry)
      index = list.curselection.first
      choice = @choices[index]
      callback.call(*choice.values_at(:file, :line))
    end

    def grep(input)
      @choices = []

      if @glob
        input, query = @glob, input
      else
        input, query = input.split(/ /, 2)
        input, query = nil, input unless query
        input ||= '*'

        return [] if !query || query.size < 3 # protect a little
      end

      regex = /#{Regexp.escape(query)}/

      Dir.glob input do |file|
        next unless ::File.file?(file)

        File.open file do |io|
          io.each_line.with_index do |line, idx|
            next unless line =~ regex
            @choices << {file: file, line: idx, match: line.strip}
          end
        end
      end

      return @choices
    end
  end
end
