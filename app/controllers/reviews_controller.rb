class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in 

    def index 
        @reviews = Review.all 
    end

    def new 
        @review = Review.new
    end
end
