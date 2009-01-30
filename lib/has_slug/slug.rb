class String
  # convert strings to slugs that are lowercase an only contain alphanumeric
  # characters, dashes and sometimes dots
  def to_slug
    slug = self
    
    # Transliterate
    slug = Unicode.normalize_KD(slug).gsub(/[^\x00-\x7F]/n,'')

    # Convert to lowercase
    slug.downcase!
    
    # Change seperators (like spaces) to dashes
    slug.gsub!(/[+_',\/|;; ]/, '-')
  
    # Dot's should be saved only when they have letter or number on both sides
    # (this preserves file extensions)
    slug.gsub!(/[^\w\d]\.+/, '-')
    slug.gsub!(/\.+[^\w\d]/, '-')    
    
    # Replace everything that is not letter, number, dash or dot with a dash
    slug.gsub!(/[^\w\d.-]/, '-')
    
    # Strip dots from begining and end
    slug.gsub!(/^\.+/, '')
    slug.gsub!(/\.+$/, '')
    
    # Strip dashes from begining and end
    slug.gsub!(/^-(.+)+/, '\1')
    slug.gsub!(/(.+)-+$/, '\1')

    # Change multiple succesive dashes to single dashe.
    slug.gsub!(/-+/, '-')
    
    slug
  end
end
