module MoviesHelper

    def index_header
        if @user
            "#{@user.username} 's Movies:"
        else
            "All Movies" 
        end
    end

end
