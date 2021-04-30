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
        @user = User.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
            u.username = auth[:info][:first_name]
            u.email = auth[:info][:email]
            u.password = SecureRandom.hex(20)
        end
        if @user.valid?
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else
            redirect_to login_path
        end
    end

    private 

    def auth 
        request.env['omniauth.auth']
    end

end
