require 'rails_helper'

RSpec.describe "Gifs", type: :system, js: true do
  let(:user) { create(:user, email: 'test@example.com') }

  context 'upload GIF' do
    before do
      login_as user, scope: :user
      visit new_gif_path
    end

    it 'create gif' do
      attach_file('gif[image]', Rails.root.join('spec/factories/images/lulu_wink.gif'), visible: :all)
      fill_in('gif[title]', with: 'るるのウィンク')
      fill_in('gif[source_url]', with: 'https://youtu.be/JReuGEiCe1U?t=7721')

      find('.tagify__input').native.send_keys('鈴原るる')
      find('.tagify__input').native.send_keys(:enter)

      click_button '登録する'
      expect(page).to have_text('鈴原るる')
    end
  end
end
