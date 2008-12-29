require 'rubygems'
require 'test/unit'
require 'sqlite3'
require 'activerecord'
require 'shoulda'
require 'factory_girl'

HAS_SLUG_ROOT = File.dirname(__FILE__) + "/.."
$:.unshift("#{HAS_SLUG_ROOT}/lib")

ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                        :dbfile  => ":memory:")
require 'has_slug'
require "#{HAS_SLUG_ROOT}/test/schema.rb"

Dir["#{HAS_SLUG_ROOT}/test/models/*"].each { |f| require f }
Dir["#{HAS_SLUG_ROOT}/test/factories/*"].each { |f| require f }

class Test::Unit::TestCase
  def reset_database!
    City.destroy_all
    Restaurant.destroy_all
    Kitchen.destroy_all
  end
end