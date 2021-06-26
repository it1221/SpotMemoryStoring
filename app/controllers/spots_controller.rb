class SpotsController < ApplicationController
  before_action :logged_in?, only: [:index]

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find_by(id: params[:id])
  end

  def new
    @spot = Spot.new
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


  private

    def spot_params
      params.require(:spot).permit(:name, :address)
    end
end
