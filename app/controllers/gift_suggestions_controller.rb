class GiftSuggestionsController < ApplicationController
  #before_action :authenticate_user! I need to implement OAuth in my stuff still
  #before_action :set_event still need to connect

  skip_before_action :authenticate_user!, only: [:new, :create], raise: false

  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create
    @gift_suggestion = GiftSuggestion.new(gift_suggestion_params)

    # @gift_suggestion.user = current_user
    # @gift_suggestion.recipient =
    # @gift_suggestion.event =

    #if @gift_suggestion.save
    flash[:notice] =  "Gift suggestion saved."
    redirect_to new_gift_suggestion_path

    #else
    #  flash[:notice] = "Could not save suggestion."
    # render :new, status: :unprocessable_entity



  end



  private
  def gift_suggestion_params
    params.require(:gift_suggestion).permit(:title, :description)

  end

end
