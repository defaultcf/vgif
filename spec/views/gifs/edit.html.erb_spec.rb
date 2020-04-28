# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'gifs/edit', type: :view do
  before(:each) do
    @gif = assign(:gif, create(:gif))
  end

  it 'renders the edit gif form' do
    render

    assert_select 'form[action=?][method=?]', gif_path(@gif), 'post' do
      assert_select 'input[name=?]', 'gif[image]'
      assert_select 'input[name=?]', 'gif[title]'
      assert_select 'input[name=?]', 'gif[source_url]'
      assert_select 'input[name=?]', 'gif[tag_list]'
    end
  end
end
