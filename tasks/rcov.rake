desc 'code coverage'
task :rcov => :clean do
  specs = Dir['spec/innate/**/*.rb']
  specs -= Dir['spec/innate/cache/common.rb']

  # we ignore adapter as this has extensive specs in rack already.
  ignore = %w[ gem rack bacon innate/adapter\.rb ]
  ignore << 'fiber\.rb' if RUBY_VERSION < '1.9'

  ignored = ignore.join(',')

  cmd = "rcov --aggregate coverage.data --sort coverage -t --%s -x '#{ignored}' %s"

  while spec = specs.shift
    puts '', "Gather coverage for #{spec} ..."
    html = specs.empty? ? 'html' : 'no-html'
    sh(cmd % [html, spec])
  end
end
