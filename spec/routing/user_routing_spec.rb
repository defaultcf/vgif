require 'rails_helper'

RSpec.describe User::InfoController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/user/i544c').to route_to('user/info#show', username: 'i544c')
    end
  end
end
