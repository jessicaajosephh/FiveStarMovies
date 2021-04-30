class Movie < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :reviews 
    has_many :users, through: :reviews

    def genre_attributes=(attr)
        self.genre = Genre.find_or_create_by(attr) if !attr[:name].blank?
    end
end
