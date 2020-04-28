# frozen_string_literal: true

class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery except: :developer

  def twitter
    authorize
  end

  def developer
    authorize
  end

  def failure
    set_flash_message! :alert, :failure, kind: 'Twitter', reason: failure_message
    redirect_to root_path
  end

  private

  def authorize
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: 'Twitter')
      end
    else
      session['devise.twitter_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_session_url
    end
  end
end
