class City < ActiveRecord::Base
  has_slug :name
  
  has_many :restaurants
  
  has_many :kitchens,
           :through => :restaurants
end