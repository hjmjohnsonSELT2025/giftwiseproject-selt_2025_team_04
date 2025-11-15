class HomeController < ApplicationController
  def index
    @gifts = Gift.all
    @username = current_user.email
    @username = @username[0,@username.index('@')]
    @events = Event.all.order(date: :desc)
  end
end
