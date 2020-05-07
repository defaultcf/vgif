# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Gifs', type: :system, js: true do
  let(:user) { create(:user, email: 'test@example.com') }

  context 'upload GIF' do
    before do
      login_as user, scope: :user
      visit new_gif_path
    end

    it 'create GIF successfully' do
      attach_file(
        'gif[image]',
        Rails.root.join('spec/factories/images/lulu_wink.gif'),
        visible: :all,
      )
      fill_in('gif[title]', with: 'るるのウィンク')
      fill_in('gif[source_url]', with: 'https://youtu.be/JReuGEiCe1U?t=7721')

      find('.tagify__input').native.send_keys('鈴原るる')
      find('.tagify__input').native.send_keys(:enter)

      expect do
        click_button '登録する'
      end.to change(Gif, :count).by(1)
    end

    it 'suggest meta data with remote image url' do
      stub_request(:get, 'https://gifs.com/gif/gZNDjZ')
        .to_return(body: '
          titleOfVideo = "武器を振り回す鈴原",
          yid = "29nfCCThT2k",
          start = "82.2",
          sample = "hogehoge",
        ')
      fill_in('gif[remote_image_url]', with: 'https://j.gifs.com/gZNDjZ.gif')
      sleep(2)
      suggest_title = find('#gif_title').value
      suggest_source_url = find('#gif_source_url').value
      expect(suggest_title).to eq '武器を振り回す鈴原'
      expect(suggest_source_url).to eq 'https://youtu.be/29nfCCThT2k?t=82'
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
      expect do
        click_link '本当に削除する'
      end.to change(Gif, :count).by(-1)
    end
  end
end
