class Api::GifscomController < ApplicationController
  def get_meta
    unless params[:gifs_id]&.match(/\w+\z/)
      render json: { message: 'invalid gifs_id' }, status: 403
      return
    end

    uri = URI.parse("https://gifs.com/gif/#{params[:gifs_id]}")
    res = Net::HTTP.get_response(uri)
    yid = res.body.match(/yid = "(\S+)"/)
    start = res.body.match(/start = "(\S+)"/)

    render json: {yid: yid ? yid[1] : '', start: start ? start[1] : ''}
  end
end
