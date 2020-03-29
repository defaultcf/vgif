class TagsController < ApplicationController
  def index
  end

  def show
    @gifs = Gif.tagged_with(params[:tag_name])
  end
end
