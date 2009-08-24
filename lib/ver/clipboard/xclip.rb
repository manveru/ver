module VER
  class ClipBoard
    # xclip is a command line interface to X selections (clipboard)
    #
    # See the xclip manpage for more information.
    class XClip
      def initialize
        @exec = File.executable?(`which xclip`.chomp)
      end

      def copy_file(path)
        system 'xclip', File.expand_path(path)
      end

      def copy(string)
        Open3.popen3 'xclip', '-i' do |si, so, se|
          si.print string
        end if @exec
      end

      def paste
        Open3.popen3 'xclip', '-o' do |si, so, se|
          return so.read
        end if @exec
      end
    end
  end
end
