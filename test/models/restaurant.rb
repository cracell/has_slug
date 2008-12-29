class Restaurant < ActiveRecord::Base
  has_slug :name,
           :scope => :city
  
  belongs_to :city
  
  belongs_to :kitchen
end