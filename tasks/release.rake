desc 'publish to github'
task :release => [:reversion, :gemspec] do
  name, version = GEMSPEC.name, GEMSPEC.version

  sh("git add MANIFEST CHANGELOG #{name}.gemspec lib/#{name}/version.rb")

  puts "I added the relevant files, you can now run:", ''
  puts "git commit -m 'Version #{version}'"
  puts "git tag -a -m '#{version}' '#{version}'"
  puts "git push"
  puts
end
