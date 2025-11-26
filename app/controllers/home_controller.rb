class HomeController < ApplicationController
  def index
    @gifts = current_user.gifts
    @username = current_user.email
    @username = @username[0,@username.index('@')]
    @events = Event.all.order(date: :desc)
  end
end
