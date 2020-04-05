class Users::CustomFailureController < Devise::FailureApp
  def redirect_url
    :user_twitter_omniauth_authorize
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
