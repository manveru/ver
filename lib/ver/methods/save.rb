module VER
  module Methods
    # TODO: we _must_ write backup files, VER can corrupt files on a system
    #       crash for some reason.
    module Save
      module_function

      def may_close(text)
        return yield if text.pristine?
        return yield if text.persisted?

        question = "Save buffer #{text.buffer.name} " \
                   "before closing? [y]es [n]o [c]ancel: "

        text.ask question, value: 'y' do |answer, action|
          case action
          when :attempt
            case answer[0]
            when /y/i
              yield if save(text)
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

      def may_save(text, as = nil)
        last = text.store(:stat, :mtime)
        current = text.filename.mtime

        if last && current
          if last == current
            yield
          else
            question = "The buffer #{text.buffer.name} " \
                       "has changed since last save, overwrite? [y]es [n]o: "
            text.ask question, value: 'n' do |answer, action|
              case action
              when :attempt
                case answer[0]
                when /y/i
                  yield
                  :abort
                else
                  VER.warn "Save aborted"
                  :abort
                end
              end
            end
          end
        else
          yield
        end
      end

      def quit(text = nil)
        buffers = VER.buffers.values
        pending = Array.new(buffers.size)

        buffers.each_with_index do |buffer, index|
          VER.defer do
            may_close(buffer.text) do
              pending[index] = true
              p pending
              VER.exit if pending.all?
            end
          end
        end
      end

      def save_all(text)
        VER.layout.buffers.each do |name, buffer|
          save(buffer.text)
        end
      end

      def save(text)
        save_to(text, text.filename)
      end

      def save_as(text)
        dir = text.filename.dirname.to_s + '/'

        text.ask 'Filename: ', value: dir do |answer, action|
          case action
          when :complete
            Pathname(answer + '*').expand_path.glob.map{|f|
              File.directory?(f) ? "#{f}/" : f
            }
          when :attempt
            begin
              save_to(text, Pathname(answer).expand_path)
              :abort
            rescue => exception
              VER.warn exception
            end
          end
        end
      end

      def file_save(text, filename = text.filename)
        save_to(text, filename)
      end

      def file_save_popup(text, options = {})
        options = options.dup
        options[:filetypes] ||= [
          ['ALL Files',  '*'    ],
          ['Text Files', '*.txt'],
        ]

        filename = text.filename
        options[:initialfile]      ||= ::File.basename(filename)
        options[:defaultextension] ||= ::File.extname(filename)
        options[:initialdir]       ||= ::File.dirname(filename)

        fpath = Tk.get_save_file(options)

        return unless fpath

        save_to(text, fpath)
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
      def save_to(text, to)
        may_save(text){ save_atomic(text, text.filename, to) }
      rescue => exception
        VER.error(exception)
        may_save(text){ save_dumb(text, to) }
      end

      def save_atomic(text, from, to)
        require 'tmpdir'
        sha1 = Digest::SHA1.hexdigest([from, to].join)
        temp_path = File.join(Dir.tmpdir, 'ver', sha1)
        temp_dir = File.dirname(temp_path)

        FileUtils.mkdir_p(temp_dir)
        FileUtils.copy_file(from, temp_path, preserve = true)
        save_dumb(text, temp_path) && FileUtils.mv(temp_path, to)

        success(text, "Saved to #{to}")
      rescue Errno::EACCES => ex
        # sshfs-mounts raise error but save correctly.
        if ex.backtrace[0].match(/chown\'$/)
          success(text, "Saved to #{to} (chown issue)")
        else
          VER.warn ex
          false
        end
      rescue Errno::ENOENT
        save_dumb(text, to)
      end

      def save_dumb(text, to)
        File.open(to, 'w+') do |io|
          io.write(text.value)
        end

        success(text, "Saved to #{to}")
      rescue Exception => ex
        VER.error(ex)
        return false
      end

      def success(text, message)
        VER.message message
        text.pristine = true
        Open.update_mtime(text)
        true
      end
    end
  end
end
