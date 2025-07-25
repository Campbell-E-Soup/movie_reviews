class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || session.delete(:user_return_to) || root_path
  end

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || session.delete(:user_return_to) || root_path
  end
end
