require 'unicode'
require 'has_slug/slug'

# has_slug is a slugging library for Ruby on Rails
module HasSlug

  # Load has_slug if the gem is included
  def self.enable
    return if ActiveRecord::Base.methods.include? 'has_slug'
    
    ActiveRecord::Base.class_eval { extend HasSlug::ClassMethods }
  end
  
  module ClassMethods 

    # Valid options for the has_slug method
    VALID_HAS_SLUG_OPTIONS = [:scope, :slug_column].freeze
    
    # Default options for the has_slug method
    DEFAULT_HAS_SLUG_OPTIONS = { :scope => nil, :slug_column => 'slug' }.freeze

    # Set up an ActiveRecord model to use a slug.
    #
    # The attribute argument can be one of your model's columns, or a method
    # you use to generate the slug.
    #
    # Options:
    # * <tt>:scope</tt> - The scope of the slug
    # * <tt>:slug_column</tt> - The column that will be used to store the slug in (defaults to slug)
    def has_slug(attribute, options = {})
      options.assert_valid_keys(VALID_HAS_SLUG_OPTIONS)
      
      options = DEFAULT_HAS_SLUG_OPTIONS.merge(options).merge(:attribute => attribute)
      
      if defined?(has_slug_options)
        raise Exception, "has_slug_options is already defined, you can only call has_slug once"
      end
      
      write_inheritable_attribute(:has_slug_options, options)
      class_inheritable_reader(:has_slug_options)
      
      if columns.any? { |column| column.name.to_s == options[:slug_column].to_s }
        require 'has_slug/sluggable_class_methods'
        require 'has_slug/sluggable_instance_methods'
        
        extend SluggableClassMethods
        include SluggableInstanceMethods
        
        before_save :set_slug, :if => :new_slug_needed?
      else
        require 'has_slug/not_sluggable_class_methods'
        require 'has_slug/not_sluggable_instance_methods'
        
        extend NotSluggableClassMethods
        include NotSluggableInstanceMethods
      end
    end
  end
end

if defined?(ActiveRecord)
  HasSlug::enable
end