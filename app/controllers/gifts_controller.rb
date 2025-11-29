class GiftsController < ApplicationController
  def new
    @new_gift = Gift.new # for use with the form_with helper

    if params[:gift_suggestion_id].present? # so if user comes from suggestions autofills
      suggestion = GiftSuggestion.find_by(id: params[:gift_suggestion_id])

      if suggestion
        @new_gift.name         = suggestion.title
        @new_gift.description  = suggestion.description
        @new_gift.price        = suggestion.estimated_price
        @new_gift.recipient_id = suggestion.recipient_id
        @new_gift.event_id     = suggestion.event_id
      end
    else
      @new_gift.recipient_id ||= params[:recipient_id]
      @new_gift.event_id ||= params[:event_id]

    end
  end


  def create
    @new_gift = Gift.new(@save_params)
    @new_gift.user = current_user #sorry making it work with mine can change
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
    params.require(:gift).permit(:name, :description, :recipient_id, :price, :event_id)
  end
end
