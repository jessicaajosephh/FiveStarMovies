class MoviesController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def new
        @movie = Movie.new
    end
    
end
