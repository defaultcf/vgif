require 'rails_helper'

RSpec.describe "Api::Gifscoms", type: :request do
  describe "GET /get_meta" do
    it "returns http success" do
      get api_gifscom_get_meta_path, params: { gifs_id: '3d3d-gZNDjZ' }
      expect(response).to have_http_status(:success)
    end
  end
end
