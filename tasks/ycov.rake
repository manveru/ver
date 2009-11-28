begin
  require 'yard'

  task 'Show Documentation coverage'
  task :ycov => ['.yardoc'] do
    YARD::Registry.load_yardoc
    code_objects = YARD::Registry.paths.map{|path| YARD::Registry.at(path) }
    code_objects.delete_if{|obj| obj.type == :root }
    without_doc, with_doc = code_objects.partition{|obj| obj.docstring.empty? }

    documented = with_doc.size
    undocumented = without_doc.size
    total = documented + undocumented
    percentage = (documented / 0.01) / total

    puts "Documentation coverage is %d/%d (%3.1f%%)" % [documented, total, percentage]
  end

  task 'ycov-full' => ['.yardoc'] do
    require 'builder'

    YARD::Registry.load_yardoc
    code_objects = YARD::Registry.paths.map{|path| YARD::Registry.at(path) }
    code_objects.delete_if{|obj| obj.type == :root }
    without_doc, with_doc = code_objects.partition{|obj| obj.docstring.empty? }

    list_objects = lambda{|body, list|
      body.table(:width => '100%') do |table|
        list.group_by{|obj| obj.type }.
          sort_by{|k,v| k.to_s }.each do |type, objects|

          table.tr do |tr|
            tr.th(type.to_s, :colspan => 2)
          end

          objects.sort_by{|obj| obj.path }.each do |obj|
            table.tr do |tr|
              tr.td obj.path
              tr.td "#{obj.file} +#{obj.line}"
            end
          end
        end
      end
    }

    File.open('ycov.html', 'w+') do |ycov|
      builder = Builder::XmlMarkup.new(:target => ycov, :indent=>2)
      builder.html do |html|
        html.head do |head|
          head.title 'YARD Coverage report'
        end

        html.body do |body|
          body.h1 'YARD Coverage report'

          body.h2 "#{without_doc.size} Undocumented objects"
          list_objects[body, without_doc]

          body.h2 "#{with_doc.size} Documented objects"
          list_objects[body, with_doc]
        end
      end
    end
  end

  file '.yardoc' => FileList['lib/**/*.rb'] do
    files = ['lib/**/*.rb']
    options = ['--no-output', '--private']
    YARD::CLI::Yardoc.run(*(options + files))
  end

  desc 'Generate YARD documentation'
  task :yardoc => ['.yardoc'] do
    files = ['lib/**/*.rb']
    options = [
      '--output-dir', 'ydoc',
      '--readme', PROJECT_README,
      '--db', '.yardoc',
      '--private']
    YARD::CLI::Yardoc.run(*(options + files))
  end
rescue LoadError
  # you'll survive
end
