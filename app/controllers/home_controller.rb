class HomeController < ApplicationController
  def index
    @gifts = Gift.all
    @events = Event.all
  end
end
