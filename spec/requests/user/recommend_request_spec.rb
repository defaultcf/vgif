require 'rails_helper'

RSpec.describe "User::Recommends", type: :request do

  describe "GET /show" do
    let(:user) { create(:user) }

    it 'when not login, redirect to login page' do
      get user_recommend_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http success" do
      sign_in user
      get "/user/recommend"
      expect(response).to have_http_status(:success)
    end
  end

end
