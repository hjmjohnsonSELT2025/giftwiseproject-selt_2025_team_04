require "rails_helper"

RSpec.describe FriendsController, type: :controller do
  describe "going to friends" do
    it "should render the friends page" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      sign_in user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "searching" do
    it "should allow searching users" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      user2 = User.create!(email:"user3@bruh.com", password:"password123")
      sign_in user
      @params = {:search => {:search_term => "user3"}}
      allow(controller).to receive(:current_user).and_return(User.find_by(:email => "user5@bruh.com"))

      post :search, params: @params
      expect(assigns(:results)).to include(user2)
    end

    it "should not allow searching blank" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      user2 = User.create!(email:"user3@bruh.com", password:"password123")
      sign_in user
      @params = {:search => {:search_term => ""}}
      allow(controller).to receive(:current_user).and_return(User.find_by(:email => "user5@bruh.com"))
      post :search, params: @params
      expect(flash[:notice]).to eq("Invalid search term.")
    end

    it "should notice when no users found" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      user2 = User.create!(email:"user3@bruh.com", password:"password123")
      sign_in user
      @params = {:search => {:search_term => "T"}}
      allow(controller).to receive(:current_user).and_return(User.find_by(:email => "user5@bruh.com"))
      post :search, params: @params
      expect(flash[:notice]).to eq("No users found.")
    end
  end
end