class Movie < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :reviews 
    has_many :users, through: :reviews

    scope :alpha, -> { order(:title) }

    def genre_attributes=(attr)
        self.genre = Genre.find_or_create_by(attr) if !attr[:name].blank?
    end
end
