require 'rails_helper'

RSpec.describe "gifs/edit", type: :view do
  before(:each) do
    @gif = assign(:gif, Gif.create!(
      title: "MyString",
      user: nil,
      public: false
    ))
  end

  it "renders the edit gif form" do
    render

    assert_select "form[action=?][method=?]", gif_path(@gif), "post" do

      assert_select "input[name=?]", "gif[title]"

      assert_select "input[name=?]", "gif[user_id]"

      assert_select "input[name=?]", "gif[public]"
    end
  end
end
