require "rails_helper"

RSpec.describe GiftCommentsController, type: :controller do
  describe "going to new comments" do
    it "should render the new comment form" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      sign_in user
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "new comments redirect" do
    it "should redirect to gift page" do
      user = User.create!(email:"user5@bruh.com", password:"password123")
      sign_in user
      @params = { :gift_comment => {:user_id => user.id, :content => "content for testing", :gift_id => 1}}
      allow(controller).to receive(:current_user).and_return(User.find_by(:email => "a@b.c"))
      post :create, params: @params
      expect(response).to redirect_to("/gifts/1")
    end
  end
end