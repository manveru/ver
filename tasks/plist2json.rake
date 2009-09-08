desc 'Convert all plists to json'
task 'plist2json' do
  require './lib/ver/plist'
  require 'json'

  # This could be improved by using proper dependencies.

  # first we need location of the plist files, that is specific for my machine,
  # but can be changed via env variables.
  # The directory should point to the root directory of the svn trunk checkout:
  # svn co http://svn.textmate.org/trunk/
  location = ENV['DIR'] || '/home/manveru/prog/textmate/'
  p location

  { 'Themes/*.{tmTheme,tmtheme}'          => 'lib/ver/theme',
    'Bundles/*.tmbundle/Syntaxes/*.plist' => 'lib/ver/syntax'
  }.each do |glob, destination|
    begin
      Dir.glob(File.join(location, glob)) do |path|
        basename = File.basename(path, File.extname(path))
        jsonname = File.join(destination, "#{basename}.json")

        puts "Conversion of #{path} to #{jsonname}"

        File.open jsonname, 'w+' do |io|
          io.write JSON.pretty_unparse(VER::Plist.parse_xml(path))
        end
      end
    rescue => ex
      p ex
      mkdir_p destination
      retry
    end
  end
end
