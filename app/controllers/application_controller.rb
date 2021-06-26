class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_current_spot
  

    def set_current_user
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      else
        @current_user = nil
      end
    end
    
    def set_current_spot
      if session[:spot_id]
        @current_spot = Spot.find_by(id: session[:spot_id])
      else
        @current_spot = nil
      end
    end

    def logged_in?
      unless @current_user
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def authenticate_user?
      @user = User.find_by(id: params[:id])    
      if @user != @current_user
        flash[:danger] = "権限がありません"
        redirect_to root_path
      end
    end

    


end
