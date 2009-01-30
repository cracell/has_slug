Gem::Specification.new do |s|
  s.name = %q{has_slug}
  s.version = "0.1.5"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = %q{1.3.1}

  s.date = %q{2008-12-29}
  s.authors = ["Tom-Eric Gerritsen"]
  s.email = %q{tomeric@i76.nl}
  s.homepage = "http://www.i76.nl/"
  s.summary = %q{A slugging plugin for Ruby on Rails}
  s.description = %q{has_slug is a plugin that provides slugging capabilities to Ruby on Rails models. Inspired by the friendly_id plugin.}
  
  s.require_paths = ["lib"]
  s.files = 
    ["init.rb", "MIT-LICENSE", "Rakefile", "README.rdoc", "lib/has_slug.rb", "lib/has_slug/slug.rb", 
     "lib/has_slug/not_sluggable_class_methods.rb", "lib/has_slug/not_sluggable_instance_methods.rb",
     "lib/has_slug/sluggable_class_methods.rb", "lib/has_slug/sluggable_instance_methods.rb",
     "tasks/has_slug_tasks.rake"]
  s.test_files = 
    ["test/schema.rb", "test/test_helper.rb", "test/factories/city_factory.rb",
     "test/factories/kitchen_factory.rb", "test/factories/restaurant_factory.rb", "test/models/city.rb",
     "test/models/kitchen.rb", "test/models/restaurant.rb", "test/unit/has_slug_test.rb",
     "test/unit/slug_test.rb"]
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README.rdoc"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
 
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<unicode>, [">= 0"])
    else
      s.add_dependency(%q<unicode>, [">= 0"])
    end
  else
    s.add_dependency(%q<unicode>, [">= 0"])
  end
end