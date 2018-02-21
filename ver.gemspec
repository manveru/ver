Gem::Specification.new do |s|
  s.name = 'ver'
  s.version = '2013.03'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael 'manveru' Fellinger"]
  s.date = '2013-03-31'
  s.description = 'An advanced text editor using tk and bringing world peace.'
  s.email = 'm.fellinger@gmail.com'
  s.executables = ['ver']
  s.files = []
  s.homepage = 'http://github.com/manveru/ver'
  s.require_paths = ['lib']
  s.rubygems_version = '1.8.24'
  s.summary = 'VER is Vim & Emacs in Ruby'

  if s.respond_to? :specification_version
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      s.add_runtime_dependency('ffi-tk', ['> 2010.02'])
      s.add_development_dependency('bacon', ['= 1.1.0'])
    else
      s.add_dependency('bacon', ['= 1.1.0'])
      s.add_dependency('ffi-tk', ['> 2010.02'])
    end
  else
    s.add_dependency('ffi-tk', ['> 2010.02'])
    s.add_dependency('ffi-tk', ['> 2010.02'])
  end
end
