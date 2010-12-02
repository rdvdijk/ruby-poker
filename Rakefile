require "jeweler"
require "rake/testtask"

task :default => [:test]

Rake::TestTask.new do |test|
  test.pattern = "test/{unit,integration}/**/*_test.rb"
end

Jeweler::Tasks.new do |spec|
  spec.name = "ruby-poker"
  spec.summary = "Entity-relationship diagram for your Rails models."
  spec.description = "Automatically generate an entity-relationship diagram (ERD) for your Rails models."
  spec.authors = ["Roel van Dijk"]
  spec.email = "r.vandijk@voormedia.com"
  
  #spec.rubyforge_project = "ABC"
  #spec.homepage = "http://ABC.rubyforge.org/"

  spec.add_runtime_dependency "activesupport", "~> 3.0"
end