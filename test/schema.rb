ActiveRecord::Schema.define(:version => 1) do
  create_table 'cities', :force => true do |t|
    t.column 'name', :string
    t.column 'slug', :string
  end
  
  create_table 'restaurants', :force => true do |t|
    t.column 'name', :string
    t.column 'slug', :string
    t.column 'city_id', :integer
    t.column 'kitchen_id', :integer
  end
  
  create_table 'kitchens', :force => true do |t|
    t.column 'name', :string
  end
end