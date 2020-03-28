require 'rails_helper'

RSpec.describe "gifs/show", type: :view do
  before(:each) do
    @gif = assign(:gif, create(:gif, {
      title: 'すいちゃんは今日も可愛い',
      source_url: 'https://youtube.com',
    }))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/すいちゃんは今日も可愛い/)
    expect(rendered).to match(/https:\/\/youtube\.com/)
  end
end
