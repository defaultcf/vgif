require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'success to create using FactoryBot' do
    expect(user).to be_valid
  end

  context 'invalid attributes' do
    it 'duplicated username' do
      create(:user, username: 'i544c')
      user.username = 'i544c'
      expect(user).to be_invalid
    end
  end
end
