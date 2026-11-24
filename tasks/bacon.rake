# frozen_string_literal: true

desc 'Run all bacon specs headless with pretty output'
task :bacon do
  require 'open3'
  require 'fileutils'
  require_relative 'support/headless_display'

  specs = PROJECT_SPECS

  # VER writes ~/.config/ver on startup (first_startup, .events, buffer_info);
  # give specs a throwaway HOME so they never touch the real one.
  spec_home = File.expand_path('../tmp/spec-home', __dir__)
  FileUtils.rm_rf(spec_home)
  FileUtils.mkdir_p(spec_home)

  some_failed = false
  specs_size = specs.size
  len = specs.map(&:size).max
  totals = [0, 0, 0, 0]

  red = "\e[31m%s\e[0m"
  green = "\e[32m%s\e[0m"
  left_format = "%4d/%d: %-#{len + 11}s"
  spec_format = '%d specifications (%d requirements), %d failures, %d errors'
  summary_re = /(\d+) specifications \((\d+) requirements\), (\d+) failures, (\d+) errors/

  HeadlessDisplay.with_display do |display_env|
    env = display_env.merge('HOME' => spec_home)

    specs.each_with_index do |spec, idx|
      print(format(left_format, idx + 1, specs_size, spec))

      out, err, = Open3.capture3(env, FileUtils::RUBY, spec)
      out.strip!
      err.strip!
      total = out.match(summary_re)&.captures&.map(&:to_i)

      if total
        totals = totals.zip(total).map { |a, b| a + b }
        tests, _, failures, errors = total
      end

      if total && tests.positive? && (failures + errors).zero?
        puts((green % '%6d passed') % tests)
      else
        some_failed = true
        puts(red % '       failed')
        puts out unless out.empty?
        puts err unless err.empty?
      end
    end
  end

  total_color = some_failed ? red : green
  puts(total_color % (spec_format % totals))
  exit 1 if some_failed
end
