# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'gifs/index', type: :view do
  before(:each) do
    assign(:gifs, [
      create(:gif),
      create(:gif),
    ])
  end

  it 'renders a list of gifs' do
    render
    assert_select 'img.gif', count: 2
  end
end
