# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Gifscoms', type: :request do
  describe 'GET /fetch_meta' do
    before do
      stub_request(:get, 'https://gifs.com/gif/3d3d-gZNDjZ')
        .to_return(body: '
          titleOfVideo = "武器を振り回す鈴原",
          yid = "29nfCCThT2k",
          start = "82.2",
          sample = "hogehoge",
        ')
    end

    it 'returns http success' do
      get api_gifscom_fetch_meta_path, params: { gifs_id: '3d3d-gZNDjZ' }
      expect(response).to have_http_status(:success)
      response_json = JSON.parse(response.body)
      expect(response_json).to include(
        'title' => '武器を振り回す鈴原',
        'yid' => '29nfCCThT2k',
        'start' => '82.2',
      )
    end
  end
end
