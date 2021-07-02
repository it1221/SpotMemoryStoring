class SpotsController < ApplicationController
  before_action :logged_in?
  before_action :reset_user_content_session, only: [:show, :new, :edit]
  before_action :authenticate_user?, only: [:edit, :update, :destroy]

  def index
    @user = User.find(session[:show_user_id])
    session[:user_content] = "spot"
    redirect_to @user
  end

  def show
    @spot = Spot.find(params[:id])
    @user = User.find(@spot.user_id)
    session[:show_user_id] = @user.id
    session[:spot_id] = @spot.id
    @msg = "このスポットを削除すると、ここで作成されたメモリーも消えてしまいます。このスポットを削除してもよろしいですか？"
    if @current_user == @user
      @memories = Memory.where(spot_id: @spot.id)
    else
      @memories = Memory.where(spot_id: @spot.id).where(private: false)
    end
    gon.memo_length = @spot.memories.length
    gon.memo_latlng = @spot.to_latlng
    gon.spot_name = @spot.name
  end

  def new
    @spot = Spot.new
  end

  def create
    user = User.find(@current_user.id)
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
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    memories = Memory.where(spot_id: @spot.id)
    origin_spot_private = @spot.private
    if @spot.update(spot_params)
      if !origin_spot_private && @spot.private 
        memories.each do |m|
          m.private = true
          m.save
          flash[:info] = "スポットが非公開に切り替わったので、このスポットのメモリーも非公開になりました。"
        end
      end
      redirect_to @spot
    else
      render 'edit'
    end
  end

  def destroy
    spot = Spot.find(params[:id])
    spot.destroy
    flash[:info] = "メモリーを削除しました"
    redirect_to spots_url
  end

  private

    def spot_params
      params.require(:spot).permit(:name, :address, :private)
    end
end
