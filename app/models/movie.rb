class Movie < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :reviews 
    has_many :users, through: :reviews

    validates :title, presence: true
    validates :description, presence: true, length: { in: 20..500 }
    validates_format_of :movie_length, with: /\A\d{1}:\d{2}\z/, message: "Please format movie length as 0:00"
    validates :director, presence: true, length: { in: 2..40 }
    validates :rating, presence: true

    scope :highest_rated, -> { order(:rating_desc)}
    

    def genre_attributes=(attr)
        self.genre = Genre.find_or_create_by(attr) if !attr[:name].blank?
    end
end
