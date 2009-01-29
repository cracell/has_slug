require "#{File.dirname(__FILE__)}/../test_helper"

class SlugTest < Test::Unit::TestCase
  context 'A Slug' do
    should 'handle quotes well' do
      assert_equal 'l-atelier', "l'Atelier".to_slug
    end
  end
end