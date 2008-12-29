module HasSlug::NotSluggableClassMethods
  
  def self.extended(base)
    class << base
      alias_method_chain :find_one, :slug
      alias_method_chain :find_some, :slug
    end
  end
  
  def find_one_with_slug(id_or_slug, options = {})
    return find_one_without_slug(id_or_slug, options) if id_or_slug.is_a?(Fixnum)
    
    if match = id_or_slug.match(/^([0-9]+)/)
      result = find_one_without_slug(match[1].to_i, options)
      result.found_by_slug! if id_or_slug == result.slug
    else
      result = find_one_without_slug(id_or_slug, options)
    end
    
    return result
  end
  
  def find_some_with_slug(ids_or_slugs, options = {})
    return find_some_without_slug(ids_or_slugs, options) if ids_or_slugs.all? { |x| x.is_a?(Fixnum) }
    
    ids = ids_or_slugs.map do |id_or_slug|
            if match = id_or_slug.to_s.match(/^([0-9]+)/)
              match[1].to_i
            else
              id_or_slug
            end
          end
  
    find_options = options.dup

    find_options[:conditions] ||= [""]
    find_options[:conditions]   = [find_options[:conditions] + " AND "] if find_options[:conditions].is_a?(String)
    
    find_options[:conditions][0] << "#{quoted_table_name}.#{primary_key} IN (?)" 
    find_options[:conditions]    << ids
    
    found    = find_every(find_options)
    expected = ids_or_slugs.map(&:to_s).uniq
    
    unless found.size == expected.size
      raise ActiveRecord::RecordNotFound, "Couldn't find all #{ name.pluralize } with IDs (#{ ids_or_slugs * ', ' }) AND #{ sanitize_sql options[:conditions] } (found #{ found.size } results, but was looking for #{ expected.size })"
    end
    
    ids_or_slugs.each do |slug|
      slug_record = found.detect { |record| record.slug == slug }
      slug_record.found_by_slug! if slug_record
    end
    
    found
  end
end