module VER
  class Buffer
    # Tag and delete all trailing whitespace in the {Buffer}.
    def delete_trailing_whitespace
      @invalid_trailing_whitespace.each_range do |range|
        range.delete
      end
    end
  end
end
