task 'syntax_list' do
  require 'yaml'
  require 'pp'

  list = {}

  Dir.glob 'lib/ver/syntax/*.syntax' do |syntax|
    basename = File.basename(syntax, '.syntax')
    file_types = YAML.load_file(syntax)['fileTypes']

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
