require 'rails_helper'

RSpec.describe "User::Infos", type: :request do
  let(:user) { create(:user, username: 'i544c') }

  describe "GET /@:username" do
    it "returns http success" do
      get user_url(user)
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 if user isnt exist' do
      expect {
        get user_url('test')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET /user/edit' do
    it 'returns http success' do
      sign_in user
      get user_edit_url
      expect(response).to have_http_status(:success)
    end

    it 'when not login, redirect login page' do
      get user_edit_url
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PATCH /user/update' do
    let(:new_attributes) {
      {
        displayname: 'New Name',
      }
    }

    it 'update successful' do
      sign_in user
      old_displayname = user.displayname
      expect {
        patch user_update_url, params: { user: new_attributes }
        user.reload
      }.to change { user.displayname }.from(old_displayname).to(new_attributes[:displayname])
    end
  end
end
