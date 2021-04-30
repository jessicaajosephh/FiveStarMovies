class MoviesController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @movie = @user.movies.build
        else
            @movie = Movie.new
        end
        @movie.build_genre
    end

    def create 
        @movie = current_user.movies.build(movie_params)
        #binding.pry
        if @movie.save 
            redirect_to movies_path
        else
            render :new
        end
    end

    def index 
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @movies = @user.movies
        else
            @error = "That user doesn't exist in our database!" if params[:user_id]
            @movies = Movie.all
        end
    end

    def show 
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie  
    end

    def edit 
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie 
        @movie.build_genre if !@movie.genre
    end

    private 

    def movie_params
        params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :genre_id, genre_attributes: [:name])
    end
    
end
