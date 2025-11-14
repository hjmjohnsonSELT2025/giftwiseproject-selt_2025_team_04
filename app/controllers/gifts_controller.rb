class GiftsController < ApplicationController
  def new
    @new_gift = Gift.new # for use with the form_with helper
  end

  def create
    @save_params = {:name => params[:gift][:name], :description => params[:gift][:description], :price => params[:gift][:price].to_f, :user_id => current_user.id, :recipient_id => nil, :event_id => nil}
    puts(@save_params)
    @new_gift = Gift.new(@save_params)
    if @new_gift.save
      flash[:notice] = "New gift created!"
      redirect_to :root
    else
      flash[:alert] = "Could not save gift."
      render :new
    end
  end

  private
  def save_params
    params.require(:gift).permit(:name, :description, :user_id, :recipient_id, :price, :event_id)
  end
end
