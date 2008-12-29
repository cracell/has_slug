Factory.define :restaurant do |restaurant|
  restaurant.name 'Da Marco'
  restaurant.city { |city| city.association(:city) }
  restaurant.kitchen { |kitchen| kitchen.association(:kitchen) }
end