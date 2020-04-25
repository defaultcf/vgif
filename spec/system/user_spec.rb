require 'rails_helper'

RSpec.describe 'User', type: :system, js: true do
  let(:user) { create(:user, username: 'asacoco', displayname: 'old_displayname') }

  context 'modify info' do
    before do
      login_as user, scope: :user
      visit user_edit_path
    end

    it 'success to modify' do
      fill_in 'user[displayname]', with: '朝ココ'
      click_button '更新する'
      expect(page).to have_text('successfully')
      expect(page).to have_text('asacoco')
      expect(page).to have_text('朝ココ')
    end
  end
end
