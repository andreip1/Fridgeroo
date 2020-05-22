class Fridge < ActiveRecord::Base
    has_many :users
    has_many :items, :through => :users
end