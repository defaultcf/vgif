# frozen_string_literal: true

module CustomException
  extend ActiveSupport::Concern

  included do
    class Forbidden < ActionController::ActionControllerError; end

    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from Forbidden, with: :render_403
    end
  end

  private

  def render_500(exception)
    Raven.capture_exception(exception)
    render 'errors/500', status: :internal_server_error
  end

  def render_404
    render 'errors/404', status: :not_found
  end

  def render_403
    render 'errors/403', status: :forbidden
  end
end
