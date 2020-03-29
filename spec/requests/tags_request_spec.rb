require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/tags"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      create(:gif, tag_list: '鈴原るる')
      get "/tags/#{CGI.escape('鈴原るる')}"
      expect(response).to have_http_status(:success)
    end
  end
end
