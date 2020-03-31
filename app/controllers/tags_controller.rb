class TagsController < ApplicationController
  def index
    @tags = Gif.tag_counts_on(:tags)
  end

  def show
    @gifs = Gif.tagged_with(params[:tag_name])
  end
end
