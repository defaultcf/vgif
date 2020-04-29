# frozen_string_literal: true

class Api::GifscomController < ApplicationController
  def get_meta
    unless params[:gifs_id]&.match(/\w+\z/)
      render json: { message: 'invalid gifs_id' }, status: :forbidden
      return
    end

    uri = URI.parse("https://gifs.com/gif/#{params[:gifs_id]}")
    res = Net::HTTP.get_response(uri)
    body = res.body.encode('utf-8')

    title = body.match(/titleOfVideo = "([^\"]*)"/)
    yid = body.match(/yid = "([^\"]+)"/)
    start = body.match(/start = "([^\"]+)"/)

    render json: {
      title: title ? title[1] : '',
      yid: yid ? yid[1] : '',
      start: start ? start[1] : '',
    }
  end
end
