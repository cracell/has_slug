module HasSlug::SluggableClassMethods

  def self.extended(base) #:nodoc:#
    class << base
      alias_method_chain :find_one, :slug
      alias_method_chain :find_some, :slug
    end
  end
  
  # Find a single record that has the same slug as the given record's slug
  def find_one_with_same_slug(object)
    slug_column = has_slug_options[:slug_column]
    
    options  = if object.new_record? then {}
                                     else { :conditions => ["#{quoted_table_name}.#{primary_key} != ?", object] }
                                     end

    if scope = has_slug_options[:scope]
      scope_attribute = "#{scope}_id" if !columns.any? { |c| c.name == scope } &&
                                          columns.any? { |c| c.name == "#{scope}_id" }

      result = send("find_by_#{slug_column}_and_#{scope_attribute}",
                 object.slug, object.send(scope), options)
    else
      result = send("find_by_#{slug_column}", object.slug, options)
    end
      
    result.found_by_slug! if result

    result
  end
  
  # Find a single record using the record's slug or the record's id
  def find_one_with_slug(id_or_slug, options = {})
    return find_one_without_slug(id_or_slug, options) if id_or_slug.is_a?(Fixnum)

    slug_column = has_slug_options[:slug_column]

    if result = send("find_by_#{slug_column}", id_or_slug, options)
      result.found_by_slug!
    else
      result = find_one_without_slug(id_or_slug, options)
    end
    
    result
  end
  
  # Find multiple records using the records slugs or the records id's
  def find_some_with_slug(ids_or_slugs, options = {})
    return find_some_without_slug(ids_or_slugs, options) if ids_or_slugs.all? { |x| x.is_a?(Fixnum) }
    
    find_options = options.dup
    
    find_options[:conditions] ||= [""]
    find_options[:conditions]   = [find_options[:conditions] + " AND "] if find_options[:conditions].is_a?(String)
    find_options[:conditions][0] << "(#{quoted_table_name}.#{primary_key} IN (?)" <<
                                    " OR #{quoted_table_name}.#{has_slug_options[:slug_column]} IN (?))"
    
    find_options[:conditions] << ids_or_slugs
    find_options[:conditions] << ids_or_slugs.map(&:to_s)
    
    found    = find_every(find_options)
    expected = ids_or_slugs.map(&:to_s).uniq
    
    unless found.size == expected.size
      raise ActiveRecord::RecordNotFound, "Couldn't find all #{name.pluralize} with IDs (#{ids_or_slugs * ', '}) AND #{sanitize_sql(options[:conditions])} (found #{found.size} results, but was looking for #{expected.size})"
    end
    
    ids_or_slugs.each do |slug|
      slug_record = found.detect { |record| record.send(has_slug_options[:slug_column]) == slug }
      slug_record.found_by_slug! if slug_record
    end
    
    found
  end
end