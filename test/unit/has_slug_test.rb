require "#{File.dirname(__FILE__)}/../test_helper"

class HasSlugTest < Test::Unit::TestCase
  context 'A model' do
    setup do
      reset_database!
    end
    
    context 'without a slug column' do
      setup do
        @italian = Factory(:kitchen, :name => 'Italian')
        @french  = Factory(:kitchen, :name => 'French')
      end
      
      should 'set the slug' do
        assert_not_nil @italian.slug
      end
      
      should 'return the slug on call to #to_param' do
        assert_equal @italian.slug, @italian.to_param
      end
      
      should 'still find by id' do
        kitchen = Kitchen.find(@italian.id)

        assert_equal @italian, kitchen
        assert !kitchen.found_by_slug?
      end

      should 'find one by slug' do
        kitchen = Kitchen.find(@italian.slug)

        assert_equal @italian, kitchen
        assert kitchen.found_by_slug?        
      end

      should 'still find some by id' do
        kitchens = Kitchen.find([@italian.id, @french.id])

        assert_equal 2, kitchens.length
        assert !kitchens.any?(&:found_by_slug?)
      end

      should 'find some by slug' do
        kitchens = Kitchen.find([@italian.slug, @french.slug])

        assert_equal 2, kitchens.length
        assert kitchens.all?(&:found_by_slug?)
      end

      should 'find some by id or slug' do
        kitchens = Kitchen.find([@italian.id, @french.slug])

        assert_equal 2, kitchens.length
        assert !kitchens[0].found_by_slug?
        assert  kitchens[1].found_by_slug?
      end
    end
    
    context 'with a slug column' do
      setup do
        @new_york      = Factory(:city, :name => 'New York')
        @san_fransisco = Factory(:city, :name => 'San Fransisco')
      end
      
      context 'and a scope' do
        setup do
          @da_marco = Factory(:restaurant, :name => 'Da Marco',
                                           :city => @new_york)
        end
        
        should 'create the same slug in a different scope' do
          @da_marco_2 = Factory(:restaurant, :name => 'Da Marco',
                                             :city => @san_fransisco)
          
          assert_equal @da_marco_2.slug, @da_marco.slug
        end
      end
      
      should 'set the slug' do
        assert_equal 'new-york',      @new_york.slug
        assert_equal 'san-fransisco', @san_fransisco.slug
      end
      
      should 'return the slug on call to #to_param' do
        assert_equal @new_york.slug,      @new_york.to_param
        assert_equal @san_fransisco.slug, @san_fransisco.to_param
      end
      
      should 'not create duplicate slugs' do
        @new_york_2 = Factory(:city, :name => 'New-York')
        
        assert_not_equal @new_york_2.slug, @new_york.slug
      end
      
      should 'still find by id' do
        city = City.find(@new_york.id)
        
        assert_equal @new_york, city
        assert !city.found_by_slug?
      end
      
      should 'find one by slug' do
        city = City.find(@new_york.slug)
        
        assert_equal @new_york, city
        assert city.found_by_slug?        
      end
      
      should 'still find some by id' do
        cities = City.find([@new_york.id, @san_fransisco.id])
        
        assert_equal 2, cities.length
        assert !cities.any?(&:found_by_slug?)
      end
      
      should 'find some by slug' do
        cities = City.find([@new_york.slug, @san_fransisco.slug])
        
        assert_equal 2, cities.length
        assert cities.all?(&:found_by_slug?)
      end
      
      should 'find some by id or slug' do
        cities = City.find([@new_york.id, @san_fransisco.slug])
        
        assert_equal 2, cities.length
        assert !cities[0].found_by_slug?
        assert  cities[1].found_by_slug?
      end
    end
  end
end