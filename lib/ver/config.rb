require 'yaml'

module VER
  module_function

  # TODO: right now all config is read from ~/.config/ver - we should make sure
  #       that we can load default config from VER itself. For now we just copy
  #       all config everytime on startup
  def start_config
    first_start # unless File.directory?(Config[:rc_dir])

    require File.join(Config[:keymap])

    log = Config[:logfile, :logfile_history, :logfile_size].map{|c| c.value }
    VER.const_set('Log', Logger.new(*log))
  end

  def first_start
    FileUtils.rm_f(Config[:rc_dir])

    Config[:rc_dir, :help_dir, :blueprint_dir].each do |dir|
      FileUtils.mkdir_p(dir)
    end

    FileUtils.cp_r File.join(DIR, '../keymap'),    Config[:rc_dir]
    FileUtils.cp_r File.join(DIR, '../help'),      Config[:rc_dir]
    FileUtils.cp_r File.join(DIR, '../blueprint'), Config[:rc_dir]
    FileUtils.cp   File.join(DIR, '../ver.rb'),    Config[:rc_file]
  rescue Object => ex
    puts ex, *ex.backtrace
    exit!
  end

  Setting = Struct.new(:key, :doc, :value)
  class Setting
    # Array#join (used by File::join) expects #to_str
    def to_str
      value.to_s
    end
  end

  CONFIGURATION = {}

  class Config
    def self.[](*keys)
      if keys.size == 1
        CONFIGURATION[keys.first]
      else
        CONFIGURATION.values_at(*keys)
      end
    end

    def self.[]=(key, value)
      if found = CONFIGURATION[key]
        found.value = value
      else
        CONFIGURATION[key] = Setting.new(key, '', value)
      end
    end

    def self.set(key, doc, value)
      CONFIGURATION[key] = Setting.new(key, doc, value)
      value
    end

    def self.store(file = self[:rc_yaml])
      File.open(file, 'w+') do |yml|
        yml.puts(CONFIGURATION.to_yaml)
      end
    end

    def self.load(file = self[:rc_yaml])
      hash = YAML.load_file(file)
      CONFIGURATION.merge!(hash)
    end

    set(:rc_dir, "Path to VER configuration",
        File.expand_path("~/.config/ver"))

    set(:rc_file, "File that contains startup instructions",
        File.join(self[:rc_dir], 'ver.rb'))

    set(:help_dir, "Path to help files",
        File.join(self[:rc_dir], 'help'))

    set(:error_logfile, "File that errors are logged to",
        File.join(Dir.tmpdir, 'ver-error.log'))

    set(:logfile, "File that contains all logs",
        File.join(Dir.tmpdir, 'ver.log'))

    set(:blueprint_dir, "Path to blueprints",
        File.join(self[:rc_dir], 'blueprint'))

    set(:logfile_size, "How large may a single logfile become",
        (2 << 20)) # 2mb

    set(:logfile_history, "How many logfiles should be in rotation",
        5)

    set(:rc_yaml, "File that contains yamlized config",
        File.join(self[:rc_dir], 'ver.yaml'))

    set(:keymap, "File with keymappings",
        File.join(self[:rc_dir], 'keymap/vi'))

    word_part = VER::Keyboard::PRINTABLE.grep(/\w/)

    set(:word_break, "Regex for boundary of words",
      Regexp.union(*(VER::Keyboard::PRINTABLE - word_part)))

    set(:chunk_break, "Regex for boundary of text chunks",
        /(?:\s+)\b/)
  end
end
