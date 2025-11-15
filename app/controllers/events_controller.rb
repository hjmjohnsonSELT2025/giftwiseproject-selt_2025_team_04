# frozen_string_literal: true

class EventsController < ApplicationController

  before_action :authenticate_user!

  def event_params
    params.require(:event).permit(:title, :location, :description, :date, :start_time, :theme)
  end

  def show
    @event = Event.for_user(current_user).find_by(:id => params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
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
    @event = Event.for_user(current_user).find_by(:id => params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
    @event.update_attributes!(event_params)
    flash[:notice] = "#{@event.title} was successfully updated."
    redirect_to events_path(@event)
  end

  def destroy
    @event = Event.for_user(current_user).find_by(:id => params[:id])
    if @event == nil
      flash[:notice] = "Event not found"
      redirect_to home_index_path
    end
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' deleted."
    redirect_to home_index_path
  end
end
