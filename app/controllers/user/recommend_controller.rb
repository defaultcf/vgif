class User::RecommendController < ApplicationController
  before_action :authenticate_user!

  def show
    @tags = current_user.tag_list
    @gifs = Gif.tagged_with(@tags).with_attached_image
  end
end
