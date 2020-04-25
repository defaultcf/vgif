class User::InfoController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, except: :show

  def show
    @user = User.find_by!(username: params[:username])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @user.destroy

    flash[:notice] = 'さみしいです...いつでも戻ってきてくださいね'
    redirect_to root_path
  end

  private

    def set_user
      # current_userのままやると、form以外に影響を及ぼす為
      @user = User.find(current_user.id)
    end

    def user_params
      params.require(:user).permit(:displayname, :tag_list)
    end
end
