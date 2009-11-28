desc 'code coverage'
task :rcov => :clean do
  specs = Dir['spec/ffi-tk/**/*.rb']

  # we ignore adapter as this has extensive specs in rack already.
  ignore = %w[ gem bacon ]

  ignored = ignore.join(',')

  cmd = "rcov --aggregate coverage.data --sort coverage -t --%s -x '#{ignored}' %s"

  while spec = specs.shift
    puts '', "Gather coverage for #{spec} ..."
    html = specs.empty? ? 'html' : 'no-html'
    sh(cmd % [html, spec])
  end
end
