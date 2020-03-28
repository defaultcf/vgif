require 'rails_helper'

RSpec.describe Gif, type: :model do
  let(:user) { create(:user) }
  let(:gif) { build(:gif, user: user) }

  it 'success to create using FactoryBot' do
    expect(gif).to be_valid
  end

  context 'invalid attributes' do
    it 'title' do
      gif.title = ''
      expect(gif).to be_invalid
    end

    it 'user' do
      gif.user = nil
      expect(gif).to be_invalid
    end

    it 'source_url' do
      gif.source_url = nil
      expect(gif).to be_invalid
    end

    it 'public' do
      gif.public = nil
      expect(gif).to be_invalid
    end
  end
end
