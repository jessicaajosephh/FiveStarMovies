class SessionsController < ApplicationController

    def home
    end

    def destroy 
        session.clear 
        redirect_to root_path 
    end

    def create 
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else
            flash[:message] = "The login information that you entered does not match our records, please try again."
            redirect_to login_path #"/login"
        end
    end

    def omniauth
        binding.pry
    end

    private 

    def auth 
        request.env['omniauth.auth']
    end

end
