class HomeController < ApplicationController
  def index
    @gifts = Gift.all
    @events = Event.all.order(date: :desc)
  end
end
