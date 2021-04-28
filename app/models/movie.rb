class Movie < ApplicationRecord
    belongs_to :user
    #belongs_to :genre
    has_many :reviews 
    has_many :users, through: :reviews 
end
