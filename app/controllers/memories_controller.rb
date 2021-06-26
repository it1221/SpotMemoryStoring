class MemoriesController < ApplicationController
  before_action :logged_in?, only: [:index]
  
  
  def index
    @memories = Memory.all
    redirect_to user_path(@current_user)
  end

  def show
    @memory = Memory.find_by(id: params[:id])
    @spot = Spot.find_by(id: @current_spot.id)
    @user = User.find_by(id: @memory.user_id)
    @time_format = "#{"%P" == "am" ? "午前" : "午後"}%l:%M - %Y年%-m月%-d日"
  end

  def new
    @memory = Memory.new
    @spot = Spot.new
    @spot.name = session[:spot_name]
    @spot = session[:spot_id]
  end

  def create
    user = User.find_by(id: @current_user.id)
    @memory = @current_spot.memories.build(memory_params)
    @memory.private = params[:memory][:private] == 1 ? true : false
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

  def format_time
    self.created_at.strftime(@time_format)
  end


  private 

    def memory_params
      params.require(:memory).permit(:title, :content)
    end

end
