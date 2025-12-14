require "rails_helper"

RSpec.describe FriendsController, type: :controller do
  describe "going to friends" do
    before do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
    it "should render the friends page" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      sign_in user
      get :index
      expect(response).to render_template('index')
    end
    after do
      User.set_callback(:create, :after, :send_welcome_email)
    end
  end

  describe "searching" do
    before do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
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

    after do
      User.set_callback(:create, :after, :send_welcome_email)
    end
  end
  describe "requesting a friend" do
    before do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
    it "should send an email" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      user2 = User.create!(email:"user3@bruh.com", password:"password123")
      obj = double
      other_obj = double
      allow(other_obj).to receive(:deliver_now).and_return(nil)
      expect(obj).to receive(:friend_request).and_return(other_obj)
      expect(UserMailer).to receive(:with).with(user: user2, requestee:user).and_return(obj)

      sign_in user
      post :create_request, params: {id: user2.id}
    end
    after do
      User.set_callback(:create, :after, :send_welcome_email)
    end
  end
end