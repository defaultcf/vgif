require 'rails_helper'

RSpec.describe "gifs/show", type: :view do
  before(:each) do
    user = create(:user)
    allow(view).to receive(:current_user).and_return(user)
    assign(:gif, create(:gif, {
      title: 'すいちゃんは今日も可愛い',
      source_url: 'https://youtube.com',
      tag_list: [{value: '星街すいせい'}, {value: '可愛い'}].to_json,
      user: user,
    }))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/すいちゃんは今日も可愛い/)
    expect(rendered).to match(/https:\/\/youtube\.com/)
    expect(rendered).to match(/星街すいせい/)
  end
end
