module HasSlug::NotSluggableInstanceMethods
  attr :found_by_slug
  
  def found_by_slug!
    @found_by_slug = true
  end
  
  def found_by_slug?
    @found_by_slug
  end
  
  def sluggable
    read_attribute(self.class.has_slug_options[:attribute])
  end
  
  def slug
    id   = self.send(self.class.primary_key)
    slug = self.sluggable.to_slug
    
    "#{id}-#{slug}"
  end

  def to_param
    self.slug
  end
end