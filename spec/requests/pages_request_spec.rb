require 'rails_helper'

RSpec.describe "Pages", type: :request do
  it 'this is private page' do
    user = User.create(email: 'user@example.com', password: 'password')
    sign_in user
    get root_path
    expect(response).to render_template('pages/top')
  end
end
