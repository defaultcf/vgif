# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/tags').to route_to('tags#index')
    end

    it 'routes to #show' do
      expect(get: '/tags/suzuhara_lulu').to route_to('tags#show', tag_name: 'suzuhara_lulu')
    end
  end
end
