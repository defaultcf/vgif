require 'rails_helper'

RSpec.describe "User::Infos", type: :request do

  describe "GET /show" do
    it "returns http success" do
      create(:user, username: 'i544c')
      get "/user/i544c"
      expect(response).to have_http_status(:success)
    end
  end

end
