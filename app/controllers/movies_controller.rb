class MoviesController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def new
        @movie = Movie.new
    end

    def create 
        @movie = current_user.movies.build(movie_params)
        if @movie.save 
            redirect_to movies_path
        else
            render :new
        end
    end

    private 

    def movie_params
        params.require(:movie).permit(:title, :description, :movie_length, :director, :rating)
    end
    
end
