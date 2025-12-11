
class RecipientsController < ApplicationController
  def recipient_params
    params.require(:recipient).permit(:name,:age,:occupation,:hobbies,:likes,:dislikes,:budget,:assigned_user_id)
  end

  def show
    id=params[:id]
    @recipient=Recipient.find(id) #tbd only query for gifts for this event
    @back=params[:back]
    @event = Event.find_by(id:params[:event])
  end

  def index
    @recipients=current_user.recipients
    if params[:query].present?
      @recipients=@recipients.select do |results|
        results.name.downcase.include?(params[:query].downcase)
      end
    end
  end

  def new
    @friends = current_user.friends.all
    @recipient=current_user.recipients.build
    @back=params[:back]
    event = params[:event]
    @event = Event.find_by(id: event)
  end

  def create
    @friends = current_user.friends.all
    @recipient=current_user.recipients.build(recipient_params)
    @recipient.user=current_user
    @back=params[:back]
    @event = params[:event]
    if @recipient.save
      flash[:notice]="#{@recipient.name} was successfully created."
    else
      flash[:notice] = "Unable to create recipient: #{@recipient.errors.full_messages.join(", ")}"
    end
    unless @event.nil?
      @event = Event.find_by(id:@event)
      @recipient.events << @event
      redirect_to @back
      return
    end
    redirect_to recipients_path
  end

  def edit
    @event = Event.find_by(id:params[:event])
    @friends = current_user.friends.all
    @recipient=Recipient.find(params[:id])
    @back = params[:back]
  end

  def update
    @recipient=Recipient.find(params[:id])
    @back = params[:back]
    if @recipient.update(recipient_params)
      flash[:notice]="#{@recipient.name} was successfully updated."
      redirect_to recipients_path
    else
      flash[:warning]="enter valid characteristics"#temporary for first sprint
      redirect_to recipients_path
    end
  end

  def destroy
    @recipient=Recipient.find(params[:id])
    @recipient.destroy
    @back = params[:back]
    flash[:notice]="#{@recipient.name} was removed."
    unless @back.nil?
      redirect_to back
      return
    end
    redirect_to recipient_path
  end

  def remove_from_event
    @recipient = Recipient.find_by(id:params[:recipient])
    @event = Event.find_by(id:params[:event])
    @event.recipients.delete(@recipient)
    flash[:notice] = "#{@recipient.name} was removed from event."
    redirect_to event_path(@event)
  end
end
