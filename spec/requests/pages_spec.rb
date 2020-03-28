require 'rails_helper'

RSpec.describe "Pages", type: :request do
  it 'this is private page' do
    user = create(:user, email: 'test@example.com')
    sign_in user
    get root_path
    expect(response).to render_template('pages/top')
  end
end
