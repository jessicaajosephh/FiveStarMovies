class GenresController < ApplicationController

    def index 
        @genres = Genre.all.includes(:movies)
    end

    def show 
        @genre = Genre.find_by_id(params[:id])
    end

    def new  
    end
    
end
