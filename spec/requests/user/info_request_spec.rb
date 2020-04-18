require 'rails_helper'

RSpec.describe "User::Infos", type: :request do
  describe "GET /show" do
    it "returns http success" do
      user = create(:user, username: 'i544c')
      get user_url(user)
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 if user isnt exist' do
      expect {
        get user_url('test')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
