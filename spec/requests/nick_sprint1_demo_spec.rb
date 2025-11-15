require 'rails_helper'

RSpec.describe "NickSprint1Demos", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/nick_sprint1_demo/index"
      expect(response).to have_http_status(:success)
    end
  end

end
