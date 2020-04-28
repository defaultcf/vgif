# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'gifs/new', type: :view do
  before(:each) do
    assign(:gif, build(:gif))
  end

  it 'renders new gif form' do
    render

    assert_select 'form[action=?][method=?]', gifs_path, 'post' do
      assert_select 'input[name=?]', 'gif[image]'
      assert_select 'input[name=?]', 'gif[title]'
      assert_select 'input[name=?]', 'gif[source_url]'
      assert_select 'input[name=?]', 'gif[tag_list]'
    end
  end
end
