# frozen_string_literal: true

class EventsController < ApplicationController

  before_action :authenticate_user!

  def event_params
    params.require(:event).permit(:title, :location, :description, :date, :start_time, :theme)
  end

  def show
    @event = current_user.events.find(params[:id])
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
    @event.user = current_user

    if @event.save
      flash[:notice] = "#{@event.title} was successfully created."
      redirect_to home_index_path
    else
      flash[:warning]="error creating event"#temporary for first sprint
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
    @event.update(event_params)
    flash[:notice] = "#{@event.title} was successfully updated."
    redirect_to event_path(@event)
  end

  def destroy
    @event = current_user.events.find(params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' deleted."
    redirect_to home_index_path
  end
end
