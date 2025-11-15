# frozen_string_literal: true

class EventsController < ApplicationController

  def event_params
    params.require(:event).permit(:title, :location, :description, :date, :start_time, :theme)
  end

  def show
    id = params[:id]
    @event = Event.find(id)
  end

  def new
    # default: render 'new' template
  end

  def create
    @event = Event.create!(event_params.merge(:user_id => current_user.id))
    flash[:notice] = "#{@event.title} was successfully created."
    redirect_to home_index_path
  end

  #def edit
  #  @event = Event.find params[:id]
  #end

  def update
    @event = Event.find params[:id]
    @event.update_attributes!(event_params)
    flash[:notice] = "#{@event.title} was successfully updated."
    redirect_to events_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' deleted."
    redirect_to home_index_path
  end
end
