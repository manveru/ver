module VER
  class Syntax
    module Detector
      module_function

      EXTS_LIST = {}
      HEAD_LIST = {}

      def exts(name, exts)
        EXTS_LIST[name] = exts
      end

      def head(name, head)
        HEAD_LIST[name] = head
      end

      def names
        [EXTS_LIST.keys, HEAD_LIST.keys].flatten.compact.sort
      end

      def detect(filename, override_name = nil)
        path = Pathname(filename.to_s)
        path = path.readlink if path.symlink?

        return unless path.file?

        VER.load('detect')

        override_name || detect_ext(path) || detect_head(path)
      end

      def detect_ext(path)
        require 'ver/levenshtein'
        basename = path.basename.to_s
        return unless basename =~ /\./

        scores = {}

        EXTS_LIST.each do |name, exts|
          lowest = nil
          exts.find do |ext|
            if basename.end_with?(ext)
              distance = Levenshtein.distance(basename, ext)
              lowest ||= distance
              lowest = distance if lowest > distance
            end
            # return name if basename.end_with?(ext)
          end
          scores[name] = lowest if lowest
        end

        p scores
        found = scores.sort_by{|k,v| v }.first
        return found.first if found
      end

      def detect_head(path)
        line = path.open{|io| io.gets }
        return unless line && line.valid_encoding?

        HEAD_LIST.find do |name, head|
          return name if line =~ head
        end
      end
    end
  end
end
