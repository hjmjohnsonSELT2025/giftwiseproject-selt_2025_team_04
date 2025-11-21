class GiftsController < ApplicationController
  def show
    @gift = current_user.gifts.find(params[:id])
  end

  def new
    @new_gift = Gift.new # for use with the form_with helper
  end

  def create
    @save_params = {:name => params[:gift][:name], :description => params[:gift][:description], :price => params[:gift][:price].to_f, :user_id => current_user.id, :recipient_id => nil, :event_id => nil}
    @new_gift = Gift.new(@save_params)
    if @new_gift.save
      flash[:notice] = "New gift created!"
      redirect_to :root
    else
      flash[:alert] = "Could not save gift."
      render :new
    end
  end

  def edit
    @gift = current_user.gifts.find(params[:id])
  end

  def update
    @gift = current_user.gifts.find(params[:id])
    @save_params = {:name => params[:gift][:name], :description => params[:gift][:description], :price => params[:gift][:price].to_f, :user_id => current_user.id, :recipient_id => nil, :event_id => nil}
    if @gift.update(@save_params)
      flash[:notice] = "Gift updated."
      redirect_to :root
    else
      flash[:alert] = "Could not update gift."
      render :edit
    end
  end

  def destroy
    @gift = current_user.gifts.find(params[:id])
    @gift.destroy
    flash[:notice] = "#{@gift.name} successfully deleted."
    redirect_to :root
  end

  private
  def save_params
    params.require(:gift).permit(:name, :description, :user_id, :recipient_id, :price, :event_id)
  end
end
