require 'rails_helper'

RSpec.describe "Gifs", type: :system, js: true do
  let(:user) { create(:user, email: 'test@example.com') }

  it 'create gif' do
    login_as user, scope: :user
    visit new_gif_path
    expect(page).to have_text('登録する')
  end
end
