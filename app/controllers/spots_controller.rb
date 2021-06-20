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
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to new_memory_path
      flash[:info] = "場所を決定しました"
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
