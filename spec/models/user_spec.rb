require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'success to create using FactoryBot' do
    expect(user).to be_valid
  end

  it 'long name' do
    user.username = 'asacoco' * 2 + 'a' # 15文字
    user.displayname = 'はあちゃまっちゃまー' * 3 # 30文字
    expect(user).to be_valid
  end

  context 'invalid attributes' do
    it 'duplicated username' do
      create(:user, username: 'i544c')
      user.username = 'i544c'
      expect(user).to be_invalid
    end

    it 'longlong name' do
      user.username = 'asacoco' * 2 + 'as' # 16文字
      user.displayname = 'はあちゃまっちゃまー' * 3 + 'は' # 31文字
      expect(user).to be_invalid
    end
  end
end
