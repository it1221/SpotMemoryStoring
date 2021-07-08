class InquiriesController < ApplicationController
  before_action :admin_user?, only: [:index]

  def index
    @inquiries = Inquiry.all
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      redirect_to feed_path
    else
      flash[:danger] = "問い合わせの送信は完了していません。"
      render 'new'
    end
  end

  def feed
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    render @current_user
  end

  private

    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :content)
    end
end
