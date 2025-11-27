class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_recipient


  def index
    if @recipient
      @suggestions = GiftSuggestion.where(event_id: @event.id, recipient_id: @recipient.id)
    else
      @suggestions = GiftSuggestion.where(event_id: @event.id)
    end
    #@suggestions = GiftSuggestion.where(event: @event, recipient: @recipient)
  end
  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create


    count = params[:count].to_i || 3

    reset = if @recipient
              GiftSuggestion.where(event_id: @event.id, recipient_id: @recipient.id)
            else
              GiftSuggestion.where(event_id: @event.id, recipient_id: nil)
            end

    reset.destroy_all

    count.times do |i|
      GiftSuggestion.create!(
        user_id:      current_user.id,
        event_id:     @event.id,
        recipient_id: (@recipient ? @recipient.id: nil),
        title:        build_title(i),
        description:  default_description(i),
        estimated_price: suggested_price,
        source:       "ai" #stubbing for now will connect it
      )
    #@gift_suggestion = GiftSuggestion.new(gift_suggestion_params)

    # @gift_suggestion.user = current_user


    #else
    #  flash[:notice] = "Could not save suggestion."
    # render :new, status: :unprocessable_entity

    end
    redirect_to event_gift_suggestions_path(@event, recipient_id: @recipient.id),
                notice: "#{count} gift suggestions generated."


  end

  private
  # def gift_suggestion_params
    #params.require(:gift_suggestion).permit(:title, :description)

  #end
  def set_event
    @event = current_user.events.find(params[:event_id])
  end

  end

  def set_recipient
    if params[:recipient_id].present?
      @recipient = current_user.recipients.find_by(id: params[:recipient_id])
    else
      @recipient = nil
    end
  end
  def build_title(i)
    base = @event.title.presence || "Gift idea"
    "#{base} (option #{i+1})"
    #"#{base} + (option #{i++})"


  end
  def default_description(i)
    desc = []
    desc << "A gift idea"

    if @recipient
      desc << "for #{@recipient.name}"
      desc << "likes #{@recipient.likes})" if @recipient.likes.present?
      desc << "hobbies #{@recipient.hobbies})" if @recipient.hobbies.present?
    end

    desc << "for #{@event.title}" if @event.title.present?
    desc << "with theme #{@event.theme}" if @event.theme.present?
    desc << "(option #{i + 1})"

    desc.join(" ")
  end
  def suggested_price
    if @recipient && @recipient.budget.present?
      @recipient.budget.to_f
    else
      100.00
    end


end
