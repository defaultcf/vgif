# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user/info/show.html.erb', type: :view do
  before(:each) do
    user = assign(:user, create(:user, {
      username: 'i544c',
      displayname: 'Isaac',
    }))
    allow(view).to receive(:current_user).and_return(user)
  end

  it 'renders attributes' do
    render
    expect(rendered).to match(/Isaac/)
    expect(rendered).to match(/@i544c/)
  end
end
