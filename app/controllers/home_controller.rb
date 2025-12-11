class HomeController < ApplicationController
  def index
    @friends = current_user.friends.all
    #@gifts = current_user.gifts
    @username = current_user.email
    @username = @username[0,@username.index('@')]
    @events = current_user.events
    @next_event=@events.where("date>= ?", Date.today).order(:date).first
  end
end
