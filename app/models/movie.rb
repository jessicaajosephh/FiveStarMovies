class Movie < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :reviews 
    has_many :users, through: :reviews

    validates :title, presence: true
    validates :description, presence: true, length: { in: 20..500 }
    validates_format_of :movie_length, with: /\A\d{1}:\d{2}\z/, message: "-Please format movie length as 0:00"
    validates :director, presence: true, length: { in: 2..40 }
    validates :rating, presence: true

    scope :highest_rated, -> { order(:rating_desc)}
    
    # def self.filter(params)
    #     where("genre_id = ?", params)
    # end
    
    def self.search(params)
        left_joins(:reviews).where("LOWER(movies.title) LIKE :search OR LOWER(movies.description) LIKE :search OR LOWER(reviews.content) LIKE :search ", search: "%#{params}%")
    end

    def genre_attributes=(attr)
        self.genre = Genre.find_or_create_by(attr) if !attr[:name].blank?
    end
end
