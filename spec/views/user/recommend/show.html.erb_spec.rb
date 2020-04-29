# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user/recommend/show.html.erb', type: :view do
  before(:each) do
    user = assign(:user, create(:user))
    allow(view).to receive(:current_user).and_return(user)

    assign(:tags, %w[鈴原るる 角巻わため])
    assign(:gifs, [
      create(:gif),
      create(:gif),
    ])
  end

  it 'renders attributes' do
    render
    assert_select 'img.gif', count: 2
  end
end
