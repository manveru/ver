desc "Update list filename extentions for available syntax definitions"
task 'syntax_list' do
  require 'json'
  require 'pp'

  list = {}

  Dir.glob 'lib/ver/syntax/*.json' do |syntax|
    basename = File.basename(syntax, '.json')
    file_types = JSON.load(File.read(syntax))['fileTypes']

    if !file_types || file_types.empty?
      file_types = [basename]
    else
      file_types << basename
    end

    list[basename] = file_types.map{|f| ".#{f.downcase}" }.uniq.sort
  end

  File.open 'lib/ver/syntax_list.rb', 'w+' do |file|
    file.write 'VER::Syntax::LIST = '
    file.write list.pretty_inspect
  end
end
