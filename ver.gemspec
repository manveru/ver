# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ver}
  s.version = "2009.03.30"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael 'manveru' Fellinger"]
  s.date = %q{2009-03-30}
  s.default_executable = %q{ver}
  s.description = %q{An advanced text editor using ncurses and of course aiming for world domination.}
  s.email = %q{m.fellinger@gmail.com}
  s.executables = ["ver"]
  s.files = ["bin/ver", "bin/ver19", "blueprint/scratch", "blueprint/welcome", "help/index.verh", "keymap/diakonos.rb", "keymap/vi.rb", "lib/vendor/fuzzy_file_finder.rb", "lib/vendor/silence.rb", "lib/ver.rb", "lib/ver/buffer.rb", "lib/ver/buffer/file.rb", "lib/ver/buffer/line.rb", "lib/ver/buffer/memory.rb", "lib/ver/clipboard.rb", "lib/ver/color.rb", "lib/ver/config.rb", "lib/ver/cursor.rb", "lib/ver/error.rb", "lib/ver/keyboard.rb", "lib/ver/keymap.rb", "lib/ver/log.rb", "lib/ver/messaging.rb", "lib/ver/mixer.rb", "lib/ver/ncurses.rb", "lib/ver/syntax.rb", "lib/ver/syntax/markdown.rb", "lib/ver/syntax/ruby.rb", "lib/ver/view.rb", "lib/ver/view/ask/choice.rb", "lib/ver/view/ask/complete.rb", "lib/ver/view/ask/file.rb", "lib/ver/view/ask/fuzzy_file.rb", "lib/ver/view/ask/grep.rb", "lib/ver/view/ask/large.rb", "lib/ver/view/ask/small.rb", "lib/ver/view/doc.rb", "lib/ver/view/file.rb", "lib/ver/view/help.rb", "lib/ver/view/info.rb", "lib/ver/window.rb", "spec/content/lines.txt", "spec/content/lorem.txt", "spec/cursor.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/manveru/ver}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{VER is Vi & Emacs in Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
