class GifsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_gif, only: [:show, :edit, :update, :destroy]
  before_action :can_edit?, only: [:edit, :update, :destroy]

  # GET /gifs
  # GET /gifs.json
  def index
    @gifs = Gif.all
  end

  # GET /gifs/1
  # GET /gifs/1.json
  def show
  end

  # GET /gifs/new
  def new
    @gif = Gif.new
  end

  # GET /gifs/1/edit
  def edit
  end

  # POST /gifs
  # POST /gifs.json
  def create
    @gif = Gif.new(gif_params)

    respond_to do |format|
      if @gif.save
        format.html { redirect_to @gif, notice: 'Gif was successfully created.' }
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
        format.html { redirect_to @gif, notice: 'Gif was successfully updated.' }
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
      format.html { redirect_to gifs_url, notice: 'Gif was successfully destroyed.' }
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
      params.require(:gif).permit(:image, :title, :source_url, :public).merge(user: current_user, tag_list: tag_array)
    end

    def tag_array
      tag_list = params[:gif][:tag_list]
      tag_list.blank? ? nil : JSON.parse(tag_list).pluck("value")
    end

    def can_edit?
      render 'errors/403', status: 403 if @gif.user != current_user
    end
end
