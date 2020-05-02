# frozen_string_literal: true

class GifsController < ApplicationController
  include GifsHelper
  include PagesHelper

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_gif, only: %i[show edit update destroy]
  before_action :can_edit?, only: %i[edit update destroy]

  # GET /gifs
  # GET /gifs.json
  def index
    @gifs = Gif.all.with_attached_image
  end

  # GET /gifs/1
  # GET /gifs/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.gif { redirect_to image_public_url(@gif.image) }
      format.thumb_gif { redirect_to thumbnail_image(@gif.image) }
    end
  end

  # GET /gifs/new
  def new
    @gif = Gif.new
  end

  # GET /gifs/1/edit
  def edit; end

  # POST /gifs
  # POST /gifs.json
  def create
    @gif = Gif.new(gif_params)

    respond_to do |format|
      if @gif.save
        format.html { redirect_to @gif, notice: t('.success') }
        format.json { render :show, status: :created, location: @gif }
      else
        format.html { render :new }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifs/1
  # PATCH/PUT /gifs/1.json
  def update
    respond_to do |format|
      if @gif.update(gif_params)
        format.html { redirect_to @gif, notice: t('.success') }
        format.json { render :show, status: :ok, location: @gif }
      else
        format.html { render :edit }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifs/1
  # DELETE /gifs/1.json
  def destroy
    @gif.destroy
    respond_to do |format|
      format.html { redirect_to gifs_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gif
    @gif = Gif.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def gif_params
    params
      .require(:gif)
      .permit(:image, :remote_image_url, :title, :source_url, :tag_list)
      .merge(user: current_user)
  end

  def can_edit?
    render 'errors/403', status: :forbidden unless @gif.editable?(current_user)
  end
end
