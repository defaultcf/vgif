# frozen_string_literal: true

class Api::GifscomController < ApplicationController
  def fetch_meta
    unless params[:gifs_id]&.match(/\w+\z/)
      render json: { message: 'invalid gifs_id' }, status: :forbidden
      return
    end

    uri = URI.parse("https://gifs.com/gif/#{params[:gifs_id]}")
    render json: get_json(uri)
  end

  private

    def get_json(uri)
      res = Net::HTTP.get_response(uri)
      body = res.body.encode('utf-8', 'utf-8') # UTF-8以外として認識されるため

      title = body.match(/titleOfVideo = "([^\"]*)"/)
      yid = body.match(/yid = "([^\"]+)"/)
      start = body.match(/start = "([^\"]+)"/)

      {
        title: title ? title[1] : '',
        yid: yid ? yid[1] : '',
        start: start ? start[1] : '',
      }
    end
end
