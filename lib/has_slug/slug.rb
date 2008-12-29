class String
	# convert strings to slugs that are lowercase an only contain alphanumeric
	# characters, dashes and sometimes dots
	def to_slug
		# Transliterate
		slug = Unicode.normalize_KD(self).gsub(/[^\x00-\x7F]/n,'')
    
    # Convert to lowercase
    slug.downcase!
    
    # Change seperators (like spaces) to dashes
    slug.gsub!(/[+_,\.\/|;; ]/, '-')
    
		# Dot's should be saved only when they have letter or number on both sides
		# (this preserves file extensions)
		# slug.gsub!(/[^\w\d]\.+/, '-')
		# slug.gsub!(/\.+[^\w\d]/, '-')
		
		# Strip dots from begining and end
		slug.gsub!(/^\.+/, '')
		slug.gsub!(/\.+$/, '')
		
		# Change multiple succesive dashes to single dashe.
		slug.gsub!(/-+/, '-')
		
		# Strip dashes from begining and end
		slug.gsub!(/^-+/, '')
		slug.gsub!(/-+$/, '')
		
		# Remove everything that is not letter, number, dash or dot.
		slug.gsub!(/[^\w\d.-]/, '')
		
		slug
	end
end
