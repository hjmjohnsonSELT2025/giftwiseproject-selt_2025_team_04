class HomeController < ApplicationController
  def index
    @gifts = Gift.all
  end
end
