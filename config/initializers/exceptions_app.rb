Rails.application.configure do
  config.exceptions_app = ApplicationController.action(:show_error)
end
