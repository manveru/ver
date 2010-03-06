module VER
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
  #
  # TODO: we _must_ write backup files, VER can corrupt files on a system
  #       crash for some reason.
  class Buffer
    # Close one buffer after another, wait when one needs user input.
    def quit
      buffers = VER.buffers.each
      closer = lambda{
        begin
          buffers.next.close(&closer)
        rescue StopIteration
        end
      }
      closer.call
    end

    # Save all buffers in ordered fashion, take into account that some buffers
    # might require user interaction.
    def save_all
      buffers = VER.buffers.each
      closer = lambda{
        begin
          buffers.next.save(&closer)
        rescue StopIteration
        end
      }
      closer.call
    end

    # Try to copy the file we want to save to a temp dir, trying to preserve
    # permissions.
    # Once it's there, we overwrite the contents with the buffer contents.
    # If that worked, we move it to the original location.
    #
    # On sshfs mounts we might face chown issues, so we ignore them.
    # If this all fails for some reason, we resort to {save_dumb}
    #
    # When save was successful overall, we call the given +block+.
    def save_atomic(from, to, &block)
      require 'tmpdir'
      sha1 = Digest::SHA1.hexdigest([from, to].join)
      temp_path = File.join(Dir.tmpdir, 'ver/save', sha1)
      temp_dir = File.dirname(temp_path)

      FileUtils.mkdir_p(temp_dir)
      FileUtils.copy_file(from, temp_path, preserve = true)
      if save_dumb(temp_path)
        FileUtils.mv(temp_path, to)
        success("Saved to #{to}", &block)
      else
        false
      end
    rescue Errno::EACCES => ex
      # sshfs-mounts raise error but save correctly.
      if ex.backtrace[0].match(/chown\'$/)
        success("Saved to #{to} (chown issue)", &block)
      else
        warn(ex)
        false
      end
    rescue Errno::ENOENT
      save_dumb(to, &block)
    end

    def save_dumb(to, &block)
      File.open(to, 'w+') do |io|
        io.set_encoding(self.encoding)

        begin
          io.write(self.value)
        rescue Encoding::UndefinedConversionError => ex
          # this might happen when trying to save UTF-8 as US-ASCII
          # so just warn, try to save as UTF-8 instead.
          warn("Saving as UTF-8 because of: #{ex.class}: #{ex}")
          io.rewind
          io.set_encoding(Encoding::UTF_8)
          io.write(self.value)
          self.encoding = Encoding::UTF_8
        end
      end

      success("Saved to #{to}", &block)
    rescue Exception => ex
      warn(ex)
      VER.error(ex)
      return false
    end

    def success(message)
      self.message(message)
      self.pristine = true
      update_mtime
      yield if block_given?
      true
    end

    def save_popup(options = {}, &block)
      options = options.dup
      options[:filetypes] ||= [
        ['ALL Files',  '*'    ],
        ['Text Files', '*.txt'],
      ]

      options[:initialfile]      ||= filename.basename
      options[:defaultextension] ||= filename.extname
      options[:initialdir]       ||= filename.dirname

      fpath = Tk.get_save_file(options)
      return unless fpath
      save_to(fpath, &block)
    end

    def save(filename = self.filename, &block)
      if filename
        save_to(filename, &block)
      else
        save_as(&block)
      end
    end

    def save_to(to, &block)
      may_save{ save_atomic(filename, to, &block) }
    rescue => exception
      VER.error(exception)
      may_save{ save_dumb(to, &block) }
    end

    def save_as
      if filename = self.filename
        dir = filename.dirname.to_s + '/'
      else
        dir = Dir.pwd + '/'
      end

      message = "Save #{uri} as: "

      ask message, value: dir do |answer, action|
        case action
        when :complete
          Pathname(answer + '*').expand_path.glob.map{|f|
            File.directory?(f) ? "#{f}/" : f
          }
        when :attempt
          begin
            save_to(Pathname(answer).expand_path)
            yield if block_given?
            :abort
          rescue => exception
            warn exception
          end
        end
      end
    end

    def may_close
      return yield if pristine? || persisted?

      question = "Save buffer #{uri} before closing? " \
                 "[y]es [n]o [c]ancel: "

      ask question, value: 'y' do |answer, action|
        case action
        when :attempt
          case answer[0]
          when /y/i
            may_save{ yield if save }
            VER.message 'Saved'
            :abort
          when /n/i
            yield
            VER.message 'Closing without saving'
            :abort
          else
            VER.warn "Cancel closing"
            :abort
          end
        end
      end
    end

    def may_save(as = nil)
      last    = store(:stat, :mtime)
      current = filename.mtime rescue nil

      # if we have two mtimes
      if last && current
        # save if they're the same
        return yield if last == current
      else
         # save since there is no previous one
        return yield
      end

      question = "The buffer #{uri} has changed since last save, " \
                 "overwrite? [y]es [n]o: "
      ask question, value: 'n' do |answer, action|
        case action
        when :attempt
          case answer[0]
          when /y/i
            yield
            :abort
          else
            warn "Save aborted"
            :abort
          end
        end
      end
    end
  end
end
