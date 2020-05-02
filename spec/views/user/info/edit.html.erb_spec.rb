# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user/info/edit.html.erb', type: :view do
  before(:each) do
    user = assign(:user, create(:user, {
      username: 'i544c',
      displayname: 'Isaac',
    }))
    allow(view).to receive(:current_user).and_return(user)
  end

  it 'renders attributes' do
    render

    assert_select 'form[action=?][method=?]', user_update_path, 'post' do
      assert_select 'input[name=?]', 'user[displayname]'
      assert_select 'input[name=?]', 'user[tag_list]'
    end
  end
end
