require 'rails_helper'

RSpec.describe "Users::Infos", type: :request do

  describe "GET /show" do
    it "returns http success" do
      create(:user, username: 'i544c')
      get "/users/i544c"
      expect(response).to have_http_status(:success)
    end
  end

end
