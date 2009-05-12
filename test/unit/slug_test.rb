require "#{File.dirname(__FILE__)}/../test_helper"

class SlugTest < Test::Unit::TestCase
  context 'A Slug' do
    should 'be lowercase' do
      assert_equal 'abc', "ABC".to_slug
    end
    
    should 'have replaced spaces with dashes' do
      assert_equal 'abc-def', "abc def".to_slug
    end
    
    should 'have replaced special characters with dashes' do
      assert_equal 'l-atelier',  "l'Atelier".to_slug
      assert_equal 'five-stars', "Five*Stars".to_slug
      assert_equal '-',          "***".to_slug
    end
    
    should 'have stripped utf-8 characters' do
      assert_equal 'internationalization', "Iñtërnâtiônàlizâtiôn".to_slug 
    end
    
    should 'turn dots into dashes' do
      assert_equal 'filename-1',   "filename.1".to_slug
      assert_equal 'filename-txt', "filename.txt".to_slug
      
      assert_equal 'a-sentence', "A sentence.".to_slug
      assert_equal 'a-sentence-a-new-sentence', "A sentence. A new sentence.".to_slug
    end
    
    should 'not have trailing dashes' do
      assert_equal 'abc-def', "abc def ".to_slug
      assert_equal 'abc-def', "abc def-".to_slug
    end
    
    should 'not have leading dashes' do
      assert_equal 'abc-def', " abc def".to_slug
      assert_equal 'abc-def', "-abc def".to_slug
    end 
    
    should 'not have succesive dashes' do
      assert_equal 'abc-def', "abc  def".to_slug
    end
  end
end