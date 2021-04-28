class GenresController < ApplicationController

    def index 
        @genres = Genre.all.includes(:movies)
    end
end
