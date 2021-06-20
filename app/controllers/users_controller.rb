class UsersController < ApplicationController
  before_action :logged_in?, only: [:index, :create, :edit, :destory]
  before_action :authenticate_user?, only: [:edit, :update, :destroy]

  def index
    @users = User.all 
  end

  def show 
    @user = User.find_by(id: params[:id])
    
  end

  def new 
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました。"
      session[:user_id] = @user.id
      redirect_to "user"
    else
      flash[:danger] = "ユーザー登録に失敗しました"
      render "new"
    end
  end

  def edit
    
  end

  def update
    @user = User.find_by(id: params[:id])
    if image = params[:user][:image_name]
      @user.image_name = "#{@user.id}"
      File.binwrite("public/user_image/#{@user.image_name}.jpg", image.read)
    end
    if @user.authenticate(params[:user][:password]) && @user.update(user_params)
      flash[:info] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      flash[:danger] = "パスワードが間違っています"
      render 'edit'
    end
  end

  def destroy 
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      flash[:danger] = "メールアドレスまたはパスワードが間違っています"
      render "login_form"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :introduction, :password)
    end
end
