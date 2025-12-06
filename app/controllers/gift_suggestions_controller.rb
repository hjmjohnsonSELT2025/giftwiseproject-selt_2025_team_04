class GiftSuggestionsController < ApplicationController
  before_action :set_event
  before_action :set_recipient

  def index
    scope = GiftSuggestion.where(user_id: current_user.id)
    scope = scope.where(event_id: @event.id)         if @event
    scope = scope.where(recipient_id: @recipient.id) if @recipient
    @suggestions = scope
  end
  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create
    if params[:gift_suggestion].present?
      @gift_suggestion = GiftSuggestion.new(gift_suggestion_params)
      @gift_suggestion.user_id = current_user.id
      @gift_suggestion.event_id = @event.id         if @event
      @gift_suggestion.recipient_id = @recipient.id if @recipient

      if @gift_suggestion.save
        redirect_to new_gift_suggestion_path, notice: "Gift suggestion was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    else

    count = params[:count].to_i || 3
    count = 1 if count <= 0

    reset = GiftSuggestion.where(user_id: current_user.id)
    reset = reset.where(event_id: @event.id) if @event
    reset = reset.where(recipient_id: @recipient.id) if @recipient
    reset = reset.where(recipient_id: nil) unless @recipient
    reset.destroy_all

    service = GiftSuggestionAi.new(
      user: current_user,
      event: @event,
      recipient: @recipient
    )

    ideas = service.generate(count: count)

    if ideas.present?
      ideas.each_with_index do |idea, idx|
        GiftSuggestion.create!(
          user_id: current_user.id,
          event_id: @event&.id,
          recipient_id: @recipient&.id,
          title: idea[:title].presence || build_title(idx),
          description: idea[:description].presence || default_description(idx),
          estimated_price: idea[:estimated_price],
          source: "ai"
        )
      end
    else
      count.times do |i|
        GiftSuggestion.create!(
          user_id: current_user.id,
          event_id: @event&.id,
          recipient_id: (@recipient ? @recipient.id : nil),
          title: build_title(i),
          description: default_description(i),
          estimated_price:suggested_price,
          source: "simple"
        )
      end
    end


    # count.times do |i|
    # GiftSuggestion.create!(
    #   user_id: current_user.id,
    #   event_id: @event&.id, #same thing as below
    #   recipient_id: (@recipient ? @recipient.id: nil),
    #   title: build_title(i),
    #  description: default_description(i),
    #   estimated_price: suggested_price,
    #    source: "ai" #stubbing for now will connect it
    # )

    #end
    if @event
      redirect_to event_gift_suggestions_path(@event, recipient_id: @recipient&.id),
                  notice: "#{count} gift suggestions generated."
    else
      redirect_to gift_suggestions_path,
                  notice: "#{count} gift suggestions generated."
    end

    end
  end

  private

  def set_event
    if params[:event_id].present?
      @event = current_user.events.find_by(id: params[:event_id])
    else
      @event = nil
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
  end
  def default_description(i)
    desc = []
    desc << "A gift idea"

    if @recipient
      desc << "for #{@recipient.name}"
      desc << "likes #{@recipient.likes}"     if @recipient.likes.present?
      desc << "hobbies #{@recipient.hobbies}" if @recipient.hobbies.present?
    end

    desc << "for #{@event.title}"        if @event.title.present?
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

  def gift_suggestion_params
    params.require(:gift_suggestion).permit(:title, :description)
  end
end
