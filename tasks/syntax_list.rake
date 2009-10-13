desc "Create syntax detection definitions"
task 'syntax_list' do
  require 'json'

  File.open 'config/detect.rb', 'w+' do |file|
    file.puts '# Encoding: UTF-8'
    file.puts
    file.puts 'module VER::Syntax::Detector'

    Dir.glob 'config/syntax/*.json' do |syntax|
      plist = JSON.load(File.read(syntax))
      name = plist['name']
      file_types = plist['fileTypes']
      regex = plist['firstLineMatch']

      if file_types && file_types.any?
        # this syntax is next to useless for ruby
        file_types.delete('rb') if name == 'Ruby on Rails'

        file.puts "  exts %p, %p" % [name, file_types]
      end

      if regex
        regex.gsub!('/', '\\/')
        file.puts "  head %p, /%s/" % [name, regex.strip]
      end
    end

    file.puts 'end'
  end
end