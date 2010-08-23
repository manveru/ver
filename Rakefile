require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'time'
require 'date'

PROJECT_SPECS = Dir['spec/ver/**/*.rb']
PROJECT_MODULE = 'VER'
PROJECT_README = 'README.textile'
PROJECT_VERSION = (ENV['VERSION'] || Date.today.strftime('%Y.%m.%d')).dup

DEPENDENCIES = {
  'ffi-tk'       => {:version => '> 2010.02'},
}
DEVELOPMENT_DEPENDENCIES = {
  'bacon'        => {:version => '1.1.0'}
}

GEMSPEC = Gem::Specification.new{|s|
  s.name         = 'ver'
  s.author       = "Michael 'manveru' Fellinger"
  s.summary      = "VER is Vim & Emacs in Ruby"
  s.description  = "An advanced text editor using tk and bringing world peace."
  s.email        = 'm.fellinger@gmail.com'
  s.homepage     = 'http://github.com/manveru/ver'
  s.platform     = Gem::Platform::RUBY
  s.version      = PROJECT_VERSION
  s.files        = `git ls-files`.split("\n").sort
  s.has_rdoc     = true
  s.require_path = 'lib'
  s.bindir       = 'bin'
  s.executables  = ['ver']
}


DEPENDENCIES.each do |name, options|
  GEMSPEC.add_dependency(name, options[:version])
end

Dir['tasks/*.rake'].each{|f| import(f) }

task :default => [:bacon]

CLEAN.include('')
