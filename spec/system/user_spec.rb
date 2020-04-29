# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :system, js: true do
  let(:user) do
    user = create(:user,
                  username: 'asacoco',
                  displayname: 'old_displayname')
  end

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

  context 'recommend gifs' do
    before do
      login_as user, scope: :user
    end

    it 'success to show' do
      # FIXME: tag_listの設定がこのような書き方でしかできない
      # FactoryBot側で上手く書けるようにしたい
      user.tag_list.add '鈴原るる'
      user.tag_list.add '角巻わため'
      user.save
      user.reload

      gif1 = create(:gif)
      gif1.tag_list.add '鈴原るる'
      gif1.save
      gif2 = create(:gif)
      gif2.tag_list.add '角巻わため'
      gif2.save

      visit user_recommend_path
      expect(all('.gif').length).to eq 2
    end
  end
end
