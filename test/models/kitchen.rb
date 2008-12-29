class Kitchen < ActiveRecord::Base
  has_slug :name
  
  belongs_to :restaurant
end