require 'rails_helper'

RSpec.describe "GiftSuggestions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/gift_suggestions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
