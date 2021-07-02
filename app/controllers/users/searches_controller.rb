class Users::SearchesController < ApplicationController
  def index
    @users = User.where('name LIKE(?)', "%#{params[:name]}%")
    
    respond_to do |format|
      format.html { redirect_to :root }
      # ↓検索結果のデータをレスポンスするコード
      format.json { render json: @users }
    end
  end
end