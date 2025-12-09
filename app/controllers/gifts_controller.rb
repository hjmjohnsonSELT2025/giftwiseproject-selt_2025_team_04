class GiftsController < ApplicationController
  VISIBILITY_LIST = [["Everyone", 0], ["Everyone but recipient", 1], ["No one", 2]].freeze
  def index
    @gifts = current_user.gifts.order(created_at: :desc)
  end

  def show
    @gift = Gift.find(params[:id])
    # add code here to redirect a user if they're the recipient
  end

  def new
    @new_gift = Gift.new # for use with the form_with helper

    if params[:gift_suggestion_id].present? # so if user comes from suggestions autofills
      suggestion = GiftSuggestion.find_by(id: params[:gift_suggestion_id])

      if suggestion
        @new_gift.name              = suggestion.title
        @new_gift.description       = suggestion.description # need to take out "description:"???
        @new_gift.price             = suggestion.estimated_price
        @new_gift.recipient_id      = suggestion.recipient_id
        @new_gift.event_id          = suggestion.event_id
        @new_gift.best_vendor_name  = suggestion.best_vendor_name
        @new_gift.best_vendor_url   = suggestion.best_vendor_url
        @new_gift.best_vendor_price = suggestion.best_vendor_price
      end

    else
      @new_gift.recipient_id ||= params[:recipient_id]
      @new_gift.event_id ||= params[:event_id]

    end
  end


  def create
    #@save_params = {:name => params[:gift][:name], :description => params[:gift][:description], :price => params[:gift][:price].to_f, :user_id => current_user.id, :recipient_id => params[:gift][:recipient_id], :event_id => nil, :visibility => params[:gift][:visibility]}
    @new_gift = Gift.new(save_params.merge(user_id: current_user.id))

    if @new_gift.save
      flash[:notice] = "New gift created!"
      redirect_to gift_path(@new_gift.id)
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
    #@save_params = {:name => params[:gift][:name], :description => params[:gift][:description], :price => params[:gift][:price].to_f, :user_id => current_user.id, :recipient_id => params[:gift][:recipient_id], :event_id => nil, :visibility => params[:gift][:visibility]}
    #if @gift.update(@save_params)
    if @gift.update(save_params.merge(user_id: current_user.id))
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
    params.require(:gift).permit(:name, :description, :user_id, :recipient_id, :price, :event_id,
                                 :visibility, :best_vendor_name, :best_vendor_url, :best_vendor_price) #For optimal pricing prob will need status too
  end
end
