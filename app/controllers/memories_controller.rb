class MemoriesController < ApplicationController
  before_action :logged_in?
  before_action :reset_user_content_session, only: [:show, :new]
  before_action :authenticate_user?, only: [:edit, :update, :destroy]
  
  def index
    @user = User.find_by(id: session[:show_user_id])
    session[:user_content] = "memory"
    gon.show_flag = session[:user_content]
    redirect_to @user
  end

  def show
    @memory = Memory.find_by(id: params[:id])
    @spot = Spot.find_by(id: @memory.spot_id)
    @user = User.find_by(id: @memory.user_id)
    session[:show_user_id] = @user.id
    session[:spot_id] = @spot.id
    @msg = "このメモリーを削除してもよろしいですか？"
  end

  def new
    @memory = Memory.new
    @spot = Spot.new
  end

  def create
    user = User.find_by(id: @current_user.id)
    @memory = @current_spot.memories.build(memory_params)
    @memory.user_id = @current_user.id
    @memory.title = "タイトル#{user.memories.length + 1 }" if @memory.title.blank?
    if @memory.save
      flash[:info] = "メモリーを作成しました"
      redirect_to @memory
    else
      flash[:danger] = "メモリーの作成に失敗しました"
      render "new"
    end
  end

  def edit
    @memory = Memory.find_by(id: params[:id])
  end

  def update
    @memory = Memory.find_by(id: params[:id])
    if @memory.update(memory_params)
      flash[:info] = "メモリーを更新しました"
      redirect_to @memory
    else
      render 'edit'
    end
  end

  def destroy
    memory = Memory.find_by(id: params[:id])
    memory.destroy
    flash[:info] = "メモリーを削除しました"
    redirect_to memories_url
  end


  private 

    def memory_params
      params.require(:memory).permit(:title, :content, :private)
    end

end
