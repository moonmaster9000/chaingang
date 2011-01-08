require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "chaingang"
    gemspec.summary     = "A chainable API for ActiveResource."
    gemspec.description = "AREL has proven that chainable APIs rock. Let's give ActiveResource the same love."
    gemspec.email       = "moonmaster9000@gmail.com"
    gemspec.files       = FileList['lib/**/*.rb', 'README.rdoc']
    gemspec.homepage    = "http://github.com/moonmaster9000/chaingang"
    gemspec.authors     = ["Matt Parker", "Gary Cheong"]
    gemspec.add_dependency('activeresource', '>= 2.2')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
