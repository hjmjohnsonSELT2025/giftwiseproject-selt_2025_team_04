require 'rails_helper'

RSpec.describe "Reminders", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/reminders/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/reminders/create"
      expect(response).to have_http_status(:success)
    end
  end

end
