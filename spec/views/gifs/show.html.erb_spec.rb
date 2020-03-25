require 'rails_helper'

RSpec.describe "gifs/show", type: :view do
  before(:each) do
    @gif = assign(:gif, Gif.create!(
      title: "Title",
      user: nil,
      public: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
