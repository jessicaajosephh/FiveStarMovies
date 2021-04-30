class Review < ApplicationRecord
    belongs_to :user
    belongs_to :movie 

    validates :content, :rating, presence: true 
end
