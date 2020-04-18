require 'rails_helper'

RSpec.describe "user/info/show.html.erb", type: :view do
  before(:each) do
    assign(:user, create(:user, {
      username: 'i544c',
      displayname: 'Isaac',
    }))
  end

  it 'renders attributes' do
    render
    expect(rendered).to match(/Isaac/)
    expect(rendered).to match(/@i544c/)
  end
end
