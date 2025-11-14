require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "redirects when not logged in" do
      get home_index_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "succeeds when logged in" do
      user = User.create!(email:"user67@bruh.com", password:"password123")
      sign_in user
      get home_index_path
      expect(response).to have_http_status(:ok)
    end

    it "redirects user to sign in page after logging out" do
      user = User.create!(email:"user67@bruh.com", password:"password123")
      sign_in user
      get home_index_path
      expect(response).to have_http_status(:ok)
      sign_out user
      get home_index_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
