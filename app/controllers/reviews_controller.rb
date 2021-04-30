class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def index 
        if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
            @reviews = @movie.reviews
        else
            @error = "That movie doesn't exist in our database yet!" if params[:movie_id]
            @reviews = Review.all 
        end
    end

    def new 
        if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
            @review = @movie.reviews.build
        else
            @error = "That movie doesn't exist in our database yet!" if params[:movie_id]
            @review = Review.new
        end
    end

    def create 
        @review = current_user.reviews.build(review_params)
        if @review.save 
            redirect_to reviews_path
        else
            render :new
        end
    end

    def show 
        @review = Review.find_by(id: params[:id])
    end

    def edit 
        @review = Review.find_by(id: params[:id])
        redirect_to reviews_path if !@review || @review.user != current_user
    end

    def update 
        @review = Review.find_by(id: params[:id])
        redirect_to reviews_path if !@review || @review.user != current_user
        if @review.update(review_params)
            redirect_to review_path(@review)
        else
            render :edit 
        end
    end

    private 

    def review_params
        params.require(:review).permit(:content, :rating, :movie_id)
    end

end
