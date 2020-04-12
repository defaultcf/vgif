require 'rails_helper'

RSpec.describe "Gifs", type: :system do
  let(:user) { create(:user, email: 'test@example.com') }

  before do
    driven_by(:rack_test)
  end

  it 'create gif' do
    sign_in user
    visit '/gifs/new'
    page.attach_file('gif_image', Rails.root.join('spec', 'factories', 'images', 'lulu_wink.gif'))
    click_button '登録する'
    expect(page).to have_text('New gif')
  end
end
