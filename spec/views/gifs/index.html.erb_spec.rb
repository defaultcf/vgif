require 'rails_helper'

RSpec.describe "gifs/index", type: :view do
  before(:each) do
    assign(:gifs, [
      Gif.create!(
        title: "Title",
        user: nil,
        public: false
      ),
      Gif.create!(
        title: "Title",
        user: nil,
        public: false
      )
    ])
  end

  it "renders a list of gifs" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
