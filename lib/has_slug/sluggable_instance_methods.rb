module HasSlug::SluggableInstanceMethods
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
    read_attribute(self.class.has_slug_options[:slug_column])
  end
  
  def slug=(slug)
    write_attribute(self.class.has_slug_options[:slug_column], slug)
  end
  
  def new_slug_needed?
    self.new_record? || self.sluggable.to_slug != self.slug
  end
  
  def to_param
    self.slug || self.id
  end
  
  private
  
  def set_slug
    self.slug = self.sluggable.to_slug
    
    while existing = self.class.find_one_with_same_slug(self)
      index ||= 2
      
      self.slug = "#{self.sluggable.to_slug}_#{index}"
      
      index += 1
    end
  end
end