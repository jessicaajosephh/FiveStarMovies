module ReviewsHelper

    def review_index_header
        if @movie
            "Reviews for #{@movie.title}"
        else
            "All Reviews"
        end
    end
end
