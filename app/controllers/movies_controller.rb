class MoviesController < ApplicationController
    before_action :redirect_if_not_logged_in 
    before_action :set_movie, only: [:show, :edit, :update, :destroy]
    before_action :redirect_if_not_movie_author, only: [:edit, :update]

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
            @movies = @user.movies.alpha
        else
            @error = "That user doesn't exist in our database!" if params[:user_id]
            @movies = Movie.all.alpha  
        end
        @movies = @movies.search(params[:q].downcase) if params[:q] && !params[:q].empty?
        #@movies = @movies.filter(params[:movie][:genre_id]) if params[:movie] && params[:movie][:genre_id] 
    end

    def show 
        redirect_to movies_path if !@movie  
    end

    def edit 
        @movie.build_genre if !@movie.genre
    end

    def update 
        if @movie.update(movie_params)
            redirect_to movie_path(@movie)
        else
            render :edit 
        end
    end

    def destroy 
        @movie.destroy 
        redirect_to movies_path 
    end

    private 

    def movie_params
        params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image, :genre_id, genre_attributes: [:name])
    end

    def set_movie
        @movie = Movie.find_by_id(params[:id])
    end

    def redirect_if_not_movie_author
        redirect_to movies_path if !@movie || @movie.user != current_user
    end
    
end
