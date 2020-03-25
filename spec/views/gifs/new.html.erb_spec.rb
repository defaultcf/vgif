require 'rails_helper'

RSpec.describe "gifs/new", type: :view do
  before(:each) do
    assign(:gif, Gif.new(
      title: "MyString",
      user: nil,
      public: false
    ))
  end

  it "renders new gif form" do
    render

    assert_select "form[action=?][method=?]", gifs_path, "post" do

      assert_select "input[name=?]", "gif[title]"

      assert_select "input[name=?]", "gif[user_id]"

      assert_select "input[name=?]", "gif[public]"
    end
  end
end
