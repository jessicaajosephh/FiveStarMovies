module ReviewsHelper

    def review_index_header
        if @movie
            "Reviews for #{@movie.title}"
        else
            "All Reviews"
        end
    end

    def new_review_header
        if @review.movie
            "New Review for #{@review.movie.title}"
        else
            "New Review!"
        end
    end
end
