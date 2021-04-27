class User < ApplicationRecord
    has_secure_password 

    has_many :movies
    has_many :reviews 
    has_many :reviewed_movies, through: :reviews, source: :movie 
    has_many :genres, through: :movies 
end
