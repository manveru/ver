module VER
  module Methods
    # TODO: we _must_ write backup files, VER can corrupt files on a system
    #       crash for some reason.
    module Save
      def may_close
        return yield if pristine?
        return yield unless undo_pending?
        return yield if persisted?

        question = 'Save this buffer before closing? [y]es [n]o [c]ancel: '

        status_ask question, take: 1 do |answer|
          case answer[0]
          when 'Y', 'y'
            yield if file_save
            :saved
          when 'N', 'n'
            yield
            :close_without_saving
          else
            "Cancel closing"
          end
        end
      end

      def persisted?
        return false unless filename && filename.file?
        require 'digest/md5'

        on_disk = Digest::MD5.hexdigest(filename.read)
        in_memory = Digest::MD5.hexdigest(value)
        on_disk == in_memory
      end

      def quit
        VER.exit
      end

      def file_save(filename = self.filename)
        save_to(filename)
      end

      def file_save_popup(options = {})
        options = options.dup
        options[:filetypes] ||= [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        options[:initialfile]      ||= ::File.basename(@filename)
        options[:defaultextension] ||= ::File.extname(@filename)
        options[:initialdir]       ||= ::File.dirname(@filename)

        fpath = Tk.get_save_file(options)

        return unless fpath

        save_to(fpath)
      end

      # Some strategies are discussed at:
      #
      # http://bitworking.org/news/390/text-editor-saving-routines
      #
      # I try another, "wasteful" approach, copying the original file to a
      # temporary location, overwriting the contents in the copy, then moving the
      # file to the location of the original file.
      #
      # This way all permissions should be kept identical without any effort, but
      # it will take up additional disk space.
      #
      # If there is some failure during the normal saving procedure, we will
      # simply overwrite the original file in place, make sure you have good insurance ;)
      def save_to(to)
        save_atomic(filename, to)
      rescue => exception
        VER.error(exception)
        save_dumb(to)
      end

      def save_atomic(from, to)
        require 'tmpdir'
        sha1 = Digest::SHA1.hexdigest([from, to].join)
        temp_path = File.join(Dir.tmpdir, 'ver', sha1)
        temp_dir = File.dirname(temp_path)

        FileUtils.mkdir_p(temp_dir)
        FileUtils.copy_file(from, temp_path, preserve = true)
        save_dumb(temp_path) && FileUtils.mv(temp_path, to)

        status.message "Saved to #{to}"
        @pristine = true
        return true
      rescue Errno::EACCES => ex
        # sshfs-mounts raise error but save correctly.
        if ex.backtrace[0].match(/chown\'$/)
          status.message "Saved to #{to} (chown issue)"
          @pristine = true
          return true
        end
        raise ex
      rescue Errno::ENOENT
        save_dumb(to)
      end

      def save_dumb(to)
        File.open(to, 'w+') do |io|
          io.write(self.value)
        end

        status.message "Saved to #{to}"
        @pristine = true
        return true
      rescue Exception => ex
        VER.error(ex)
        return false
      end
    end
  end
end
