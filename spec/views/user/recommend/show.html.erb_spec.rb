require 'rails_helper'

RSpec.describe "user/recommend/show.html.erb", type: :view do
  before(:each) do
    tags = ['鈴原るる', '角巻わため']
    user = assign(:user, create(:user, {
      tag_list: tags.map { |tag| { value: tag } },
    }))
    allow(view).to receive(:current_user).and_return(user)

    assign(:tags, tags)
    assign(:gifs, tags.map { |tag| create(:gif, tag_list: [{ value: tag }]) })
  end

  it 'renders attributes' do
    render
    assert_select 'img.gif', count: 2
  end
end
