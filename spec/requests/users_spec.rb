require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user" do
    it "requires logging in" do
      get user_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "displays user profile information" do
      user = User.create!(email:"user67@bruh.com", password:"password123", preferred_name: "User", pronouns: "They/Them")
      sign_in user
      get user_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("User")
      expect(response.body).to include("They/Them")
      expect(response.body).to_not include("He/Him")
    end
  end
end
