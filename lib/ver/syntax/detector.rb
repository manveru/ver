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
        basename = path.basename.to_s
        return unless basename =~ /\./

        EXTS_LIST.find do |name, exts|
          exts.find do |ext|
            if basename.end_with?(ext)
              p basename => ext
              return name
            end
          end
        end
      end

      def detect_head(path)
        line = path.open{|io| io.gets }
        return unless line && line.valid_encoding?

        HEAD_LIST.find do |name, head|
          if line =~ head
            p line => head
            return name
          end
        end
      end
    end
  end
end