class User::InfoController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = User.find_by!(username: params[:username])
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        current_user.reload
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    current_user.destroy

    flash[:notice] = 'さみしいです...いつでも戻ってきてくださいね'
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :displayname, :tag_list)
    end
end
