class GiftSuggestionsController < ApplicationController
  before_action :set_recipient
  before_action :set_event, only: [:index, :create]


  def index
    scope = GiftSuggestion.where(user_id: current_user.id)
    scope = scope.where(recipient_id: @recipient.id) if @recipient
    scope = scope.where(event_id: @event.id)         if @event
    @suggestions = scope
  end
  def new
    @gift_suggestion = GiftSuggestion.new
  end

  def create
    count = params[:count].to_i
    count = 1 if count <= 0

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
            event_id: @event.id,
            recipient_id: @recipient.id,
            title: idea[:title].presence || build_title(idx),
            description: idea[:description].presence || default_description(idx),
            estimated_price: idea[:estimated_price],
            source: "OpenAI"
          )
        end
      else
        count.times do |i|
          GiftSuggestion.create!(
            user_id: current_user.id,
            event_id: @event&.id,
            recipient_id: @recipient.id,
            title: build_title(i),
            description: default_description(i),
            estimated_price:suggested_price,
            source: "simple"
          )
        end
      end

    redirect_to event_gift_suggestions_path(@event, recipient_id: @recipient.id),
                notice: "#{count} gift suggestions generated."
  end

  private

  def set_event
    @event = nil
    return unless params[:event_id].present?

    @event = current_user.events
                         .joins(:events_users)
                         .find_by(id: params[:event_id])

    unless @event
      redirect_to root_path, alert: "You must choose an event before generating suggestions." and return
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
    base = @event&.title.presence || "Gift idea"
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
    params.require(:gift_suggestion).permit(:title, :description, :event_id)
  end
end
