# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CustomException

  before_action :set_raven_context

  def show_error
    raise request.env['action_dispatch.exception']
  end

  private

  def set_raven_context
    Raven.user_context(id: current_user&.id)
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
