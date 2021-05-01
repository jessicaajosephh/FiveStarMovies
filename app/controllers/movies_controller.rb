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
            @movies = @user.movies.highest_rated
        else
            @error = "That user doesn't exist in our database!" if params[:user_id]
            @movies = Movie.all.highest_rated  
        end
        @movies = @movies.search(params[:q].downcase) if params[:q] && !params[:q].empty?
        #@movies = @movies.filter(params[:movie][:genre_id]) if params[:movie] && params[:movie][:genre_id] 
    end

    def show 
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie  
    end

    def edit 
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie || @movie.user != current_user
        @movie.build_genre if !@movie.genre
    end

    def update 
        @movie = Movie.find_by(id: params[:id])
        redirect_to movies_path if !@movie || @movie.user != current_user
        if @movie.update(movie_params)
            redirect_to movie_path(@movie)
        else
            render :edit 
        end
    end

    def destroy 
        @movie = Movie.find_by_id(params[:id])
        @movie.destroy 
        redirect_to movies_path 
    end

    private 

    def movie_params
        params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image, :genre_id, genre_attributes: [:name])
    end
    
end
