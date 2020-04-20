require 'rails_helper'

RSpec.describe "Gifs", type: :system, js: true do
  let(:user) { create(:user, email: 'test@example.com') }

  context 'upload GIF' do
    before do
      login_as user, scope: :user
      visit new_gif_path
    end

    it 'create GIF successfully' do
      attach_file('gif[image]', Rails.root.join('spec/factories/images/lulu_wink.gif'), visible: :all)
      fill_in('gif[title]', with: 'るるのウィンク')
      fill_in('gif[source_url]', with: 'https://youtu.be/JReuGEiCe1U?t=7721')

      find('.tagify__input').native.send_keys('鈴原るる')
      find('.tagify__input').native.send_keys(:enter)

      expect {
        click_button '登録する'
      }.to change(Gif, :count).by(1)
    end
  end

  context 'delete GIF' do
    let(:gif) { create(:gif, user: user) }
    before do
      login_as user, scope: :user
      visit gif_path(gif)
    end

    it 'delete GIF successfully' do
      find('#delete-button').click
      expect {
        click_link '本当に削除する'
      }.to change(Gif, :count).by(-1)
    end
  end
end
