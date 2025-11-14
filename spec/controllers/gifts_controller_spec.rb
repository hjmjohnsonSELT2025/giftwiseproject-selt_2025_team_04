require "rails_helper"

RSpec.describe GiftsController, type: :controller do
  describe "going to new gifts" do
    it "should render the new gift form" do
      user = User.create!(email:"user67@bruh.com", password:"password123")
      sign_in user
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "creating new gifts" do
    it "should create new gifts successfully" do
      user = User.create!(email:"user67@bruh.com", password:"password123")
      sign_in user
      @params = { :gift => {:name => "test gift", :description => "gift for testing", :price => "15.5"} }
      # allow(Gift).to receive(:new).and_return(Gift.new(@params))
      allow(controller).to receive(:current_user).and_return(User.find_by(:email => "a@b.c"))
      post :create, params: @params
      expect(response).to redirect_to("/")
    end
  end
end
