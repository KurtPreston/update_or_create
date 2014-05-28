source 'https://rubygems.org'

# Specify your gem's dependencies in update_or_create.gemspec
gemspec

spec = Bundler.load_gemspec(Dir["./{,*}.gemspec"].first)
spec.runtime_dependencies.each do |dep|
  gem dep.name, *(dep.requirement.as_list)
end
