desc "Create syntax detection definitions"
task 'syntax_list' do
  list = Hash.new{|h,k| h[k] = [] }

  Dir.glob 'config/syntax/*.rb' do |syntax|
    basename = File.basename(syntax, '.rb')
    puts "Processing #{basename}..."
    load(syntax)
    plist = eval(File.read(syntax), binding, syntax, 0)
    name = plist[:name]
    file_types = plist[:fileTypes]
    regex = plist[:firstLineMatch]

    if file_types && file_types.any?
      # this syntax is next to useless for ruby
      file_types.delete('rb') if name == 'Ruby on Rails'

      list[basename] << "  exts %p, %p" % [basename, file_types]
    end

    if regex
      regex.gsub!('/', '\\/')
      list[basename] << "  head %p, /%s/" % [basename, regex.strip]
    end
  end

  out = [
    '# Encoding: UTF-8',
    '',
    'module VER::Syntax::Detector',
    *list.sort_by{|name, lines| name.downcase }.map{|name, lines| lines.sort }.flatten,
    'end',
  ]

  File.open('config/detect.rb', 'w+'){|io| io.puts(*out) }
end
