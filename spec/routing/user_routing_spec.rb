require 'rails_helper'

RSpec.describe User::InfoController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/@i544c').to route_to('user/info#show', username: 'i544c')
    end

    it 'routes to recommend#show' do
      expect(get: '/user/recommend').to route_to('user/recommend#show')
    end

    it 'routes to #edit' do
      expect(get: '/user/edit').to route_to('user/info#edit')
    end

    it 'routes to #update' do
      expect(patch: '/user/update').to route_to('user/info#update')
    end

    it 'routes to #delete' do
      expect(delete: '/user/delete').to route_to('user/info#delete')
    end
  end
end
