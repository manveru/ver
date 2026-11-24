# frozen_string_literal: true

require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'time'
require 'date'

# keymap/vim.rb is the shared setup that keymap/vim/*.rb require, not a spec.
PROJECT_SPECS = FileList['spec/ver/**/*.rb'].exclude('spec/ver/keymap/vim.rb')
PROJECT_MODULE = 'VER'
PROJECT_README = 'README.textile'
PROJECT_VERSION = (ENV['VERSION'] || Date.today.strftime('%Y.%m.%d')).dup

DEPENDENCIES = {
  'ffi-tk' => { version: '>= 2026.07.14' },
  'abbrev' => { version: '~> 0.1' },
  'benchmark' => { version: '~> 0.5' },
  'logger' => { version: '~> 1.7' },
  'pstore' => { version: '~> 0.3' },
  'rchardet' => { version: '~> 1.10' }
}.freeze

DEVELOPMENT_DEPENDENCIES = {
  'bacon' => { version: '~> 1.2' }
}.freeze

GEMSPEC = Gem::Specification.new do |s|
  s.name         = 'ver'
  s.author       = "Michael 'manveru' Fellinger"
  s.summary      = 'VER is Vim & Emacs in Ruby'
  s.description  = 'An advanced text editor using tk and bringing world peace.'
  s.email        = 'm.fellinger@gmail.com'
  s.licenses     = ['MIT']
  s.homepage     = 'http://github.com/manveru/ver'
  s.platform     = Gem::Platform::RUBY
  s.version      = PROJECT_VERSION
  s.files        = Dir['bin/*', 'config/**/*', 'help/**/*', 'lib/**/*.rb',
                       'AUTHORS', 'CHANGELOG', 'LICENSE', 'README.textile']
                   .select { |path| File.file?(path) }.sort
  s.require_path = 'lib'
  s.bindir       = 'bin'
  s.executables  = ['ver']
  s.required_ruby_version = '>= 4.0'
end

DEPENDENCIES.each do |name, options|
  GEMSPEC.add_dependency(name, options[:version])
end

DEVELOPMENT_DEPENDENCIES.each do |name, options|
  GEMSPEC.add_development_dependency(name, options[:version])
end

Dir['tasks/*.rake'].each { |f| import(f) }

task default: [:bacon]
