class User < ActiveRecord::Base
    has_many :items
    belongs_to :fridge
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    
    # on:create if things fail
end