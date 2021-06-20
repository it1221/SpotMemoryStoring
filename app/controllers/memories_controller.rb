class MemoriesController < ApplicationController
  before_action :logged_in?, only: [:index]
  
  def index
    @memories = Memory.all
  end

  def show
    @memory = Memory.find_by(id: params[:id])
    @time_format = "#{"%P" == "am" ? "午前" : "午後"}%l:%M - %Y年%-m月%-d日"
  end

  def new
    @memory = Memory.new
    #@spot = params[:spot]
  end

  def create
    @memory = Memory.new(memory_params)
    if @memory.save
      flash[:info] = "メモリーを作成しました"
      redirect_to @memory
    else
      flash[:danger] = "メモリーの作成に失敗しました"
      render "new"
    end
  end


  private 

    def memory_params
      params.require(:memory).permit(:title, :content)
    end

end
