task :gemspec => [:manifest, :changelog] do
  gemspec_file = "#{GEMSPEC.name}.gemspec"
  File.open(gemspec_file, 'w+'){|gs| gs.puts(GEMSPEC.to_ruby) }
end

desc "package and install from gemspec"
task :install => [:gemspec] do
  sh "gem build #{GEMSPEC.name}.gemspec"
  sh "gem install #{GEMSPEC.name}-#{GEMSPEC.version}.gem"
end

desc "uninstall the gem"
task :uninstall => [:clean] do
  sh %{gem uninstall -x #{GEMSPEC.name}}
end

Gem::PackageTask.new(GEMSPEC) do |pkg|
  pkg.need_tar = true
end
