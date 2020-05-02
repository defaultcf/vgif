# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/show.html.erb', type: :view do
  before(:each) do
    assign(:gifs, [
      create(:gif, tag_list: '鈴原るる, にじさんじ'),
      create(:gif, tag_list: '鈴原るる, でびでび・でびる'),
    ])
  end

  it 'filters gifs by tag name' do
    render
    assert_select 'img.gif', count: 2
  end
end
