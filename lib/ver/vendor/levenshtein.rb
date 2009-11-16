module VER
  # Levenshtein distance algorithm implementation for Ruby, with UTF-8 support.
  #
  # The Levenshtein distance is a measure of how similar two strings s and t
  # are, calculated as the number of deletions/insertions/substitutions needed
  # to transform s into t. The greater the distance, the more the strings
  # differ.
  #
  # The Levenshtein distance is also sometimes referred to as the
  # easier-to-pronounce-and-spell 'edit distance'.
  #
  # The original author is Paul Battley (pbattley@gmail.com)
  # Modified by Michael Fellinger (m.fellinger@gmail.com)
  #
  # The original implementation is part of the 'english' gem, distributed under
  # the Ruby license.
  module Levenshtein
    module_function

    # Calculate the Levenshtein distance between two strings +str1+ and +str2+.
    # +str1+ and +str2+ will be encoded as UTF8.
    #
    # Be aware that this algorithm doesn't perform normalization.
    # If there is a possibility of different normalized forms being used,
    # normalization should be performed beforehand.
    def distance(str1, str2)
      s = str1.encode(Encoding::UTF_8).unpack('U*')
      t = str2.encode(Encoding::UTF_8).unpack('U*')

      n = s.length
      m = t.length

      return m if (0 == n)
      return n if (0 == m)

      d = (0..m).to_a
      x = nil

      (0...n).each do |i|
        e = i+1
        (0...m).each do |j|
          cost = (s[i] == t[j]) ? 0 : 1
          x = [
            d[j+1] + 1, # insertion
            e + 1,      # deletion
            d[j] + cost # substitution
          ].min
          d[j] = e
          e = x
        end
        d[m] = x
      end

      return x
    end
  end
end
