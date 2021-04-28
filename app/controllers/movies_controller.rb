class MoviesController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def new
        @movie = Movie.new
    end

    def create 
        binding.pry
    end

    private 

    def movie_params
        params.require(:movie).permit(:title, :description, :movie_length, :director, :rating)
    end
    
end
