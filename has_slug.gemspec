Gem::Specification.new do |s|
  s.name = "has_slug"
  s.version = "0.1"
  s.date = "2008-12-29"
  s.authors = ["Tom-Eric Gerritsen"]
  s.email = "tomeric@i76.nl"
  s.homepage = "http://www.i76.nl/"
  s.summary = "A slugging plugin for Ruby on Rails"
  s.description = "has_slug is a plugin that provides slugging capabilities to Ruby on Rails models. Inspired by the friendly_id plugin."
  s.files = 
    ["init.rb", "MIT-LICENSE", "Rakefile", "README.rdoc", "lib/has_slug.rb", "lib/has_slug/slug.rb", 
     "lib/has_slug/not_sluggable_class_methods.rb", "lib/has_slug/not_sluggable_instance_methods.rb",
     "lib/has_slug/sluggable_class_methods.rb", "lib/has_slug/sluggable_instance_methods.rb",
     "tasks/has_slug_tasks.rake"]
  s.test_files = 
    ["test/schema.rb", "test/test_helper.rb", "test/factories/city_factory.rb",
     "test/factories/kitchen_factory.rb", "test/factories/restaurant_factory.rb", "test/models/city.rb",
     "test/models/kitchen.rb", "test/models/restaurant.rb", "test/unit/has_slug_test.rb"]
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README.rdoc"]
  s.add_dependency("unicode", ["> 0.0.0"])
end