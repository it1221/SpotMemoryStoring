class SpotsController < ApplicationController
  before_action :logged_in?
  before_action :reset_user_show_session, only: [:show, :new, :edit]
  before_action :authenticate_user?, only: [:edit, :update, :destroy]

  def index
    @user = User.find_by(id: session[:show_user_id])
    session[:user_show] = "spot"
    redirect_to @user
    #@spots.each do |s|
    #  s.to_latlng
    #end
  end

  def show
    @spot = Spot.find_by(id: params[:id])
    session[:spot_id] = @spot.id
    gon.memo_length = @spot.memories.length
    gon.memo_lat = @spot.to_lat
    gon.memo_lng = @spot.to_lng
    gon.spot_name = @spot.name
  end

  def new
    @spot = Spot.new
    session[:user_show] = nil
  end

  def create
    user = User.find_by(id: @current_user.id)
    @spot = @current_user.spots.build(spot_params)
    @spot.name = "スポット#{user.spots.length + 1 }" if @spot.name.blank?
    if @spot.save
      flash[:info] = "場所を決定しました"
      session[:spot_name] = @spot.name
      session[:spot_id] = @spot.id
      redirect_to new_memory_url
    else
      flash[:notice]
      render new_spot_path
    end
  end

  def edit
    @spot = Spot.find_by(id: params[:id])
  end

  def update
    @spot = Spot.find_by(id: params[:id])
    if @spot.update(spot_params)
      flash[:info] = "スポットを更新しました。"
      redirect_to @spot
    else
      flash[:danger] = "スポットの編集に失敗しました。"
      render 'edit'
    end
  end


  private

    def spot_params
      params.require(:spot).permit(:name, :address)
    end
end
