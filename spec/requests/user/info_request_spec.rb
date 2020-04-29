# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Infos', type: :request do
  let(:user) { create(:user, username: 'i544c') }

  describe 'GET /@:username' do
    it 'returns http success' do
      get user_url(user)
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 if user isnt exist' do
      expect do
        get user_url('test')
      end.to raise_error(ActiveRecord::RecordNotFound)
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
    let(:new_attributes) do
      {
        displayname: 'New Name',
      }
    end

    it 'update successful' do
      sign_in user
      old_displayname = user.displayname
      expect do
        patch user_update_url, params: { user: new_attributes }
        user.reload
      end.to change { user.displayname }.from(old_displayname).to(new_attributes[:displayname])
    end

    it 'can not update username' do
      sign_in user
      expect do
        patch user_update_url, params: { user: { username: 'New Username' } }
        user.reload
      end.not_to change { user.username }
    end
  end

  describe 'DELETE /user/delete' do
    it 'delete user successfuly' do
      sign_in user
      expect do
        delete user_delete_url
      end.to change(User, :count).by(-1)
    end

    it 'redirect successful' do
      sign_in user
      delete user_delete_url
      expect(response).to redirect_to(root_path)
    end

    it 'delete user with GIFs' do
      sign_in user
      other_user = create(:user)
      create(:gif, user: user)
      create(:gif, user: other_user)
      expect do
        delete user_delete_url
      end.to change(Gif, :count).by(-1)
    end
  end
end
