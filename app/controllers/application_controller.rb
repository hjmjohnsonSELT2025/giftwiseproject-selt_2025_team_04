class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :testing?

  private
  def testing?
    Rails.env.test?
  end
end
