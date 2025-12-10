# frozen_string_literal: true

class EventsController < ApplicationController

  before_action :authenticate_user!

  def event_params
    params.require(:event).permit(:title, :location, :description, :date, :start_time, :theme, :reminders_enabled)
  end

  def show
    @event = current_user.events.find(params[:id])
    @users = @event.users
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    @event.users << current_user

    if params[:recipient_id] != nil
      params[:recipient_id].each do |recipient_id|
        @event.recipients << current_user.recipients.find(recipient_id)
      end
    else
      @event.recipients.clear
    end

    if @event.save
      flash[:notice] = "#{@event.title} was successfully created."
      redirect_to event_path(@event)
    else
      flash[:warning]="error creating event"#temporary for first sprint
      redirect_to events_path
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
    if @event.owner != current_user
      flash[:notice] = "Not authorised"
      redirect_to home_index_path
    end
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path; return
    end
    if @event.owner != current_user
      flash[:notice] = "Not authorised"
      redirect_to home_index_path; return
    end

    @event.update(event_params)

    if params[:recipient_id] != nil
      params[:recipient_id].each do |recipient_id|
        @event.recipients << current_user.recipients.find(recipient_id)
      end
    else
      @event.recipients.clear
    end

    flash[:notice] = "#{@event.title} was successfully updated."
    redirect_to event_path(@event)
  end

  def invite
    @event = current_user.events.find(params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path; return
    end
    if @event.owner != current_user
      flash[:notice] = "Not authorised"
      redirect_to event_path(@event); return
    end
    if params[:invite_id].nil?
      flash[:notice] = "No friends selected."
      redirect_to event_path(@event)
      return
    end

    unless @event.users.find_by(id: params[:invite_id]).nil?
      flash[:notice] = "Already invited."
      redirect_to event_path(@event)
      return
    end

    @other_user = User.find(params[:invite_id])

    if @other_user != nil
      @event.users << @other_user
      flash[:notice] = "User invited"
    end

    redirect_to event_path(@event)
  end

  def destroy
    @event = current_user.events.find(params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path; return
    end
    if @event.owner != current_user
      flash[:notice] = "Not authorised"
      redirect_to event_path(@event); return
    end
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' deleted."
    redirect_to home_index_path
  end
end
