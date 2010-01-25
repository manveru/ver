desc 'code coverage'
task :rcov => :clean do
  specs = PROJECT_SPECS

  ignore = %w[ gem ffi-tk ]

  ignored = ignore.join(',')

  cmd = "rcov --aggregate coverage.data --sort coverage -t --%s -x '#{ignored}' %s"

  while spec = specs.shift
    puts '', "Gather coverage for #{spec} ..."
    html = specs.empty? ? 'html' : 'no-html'
    sh(cmd % [html, spec])
  end
end
