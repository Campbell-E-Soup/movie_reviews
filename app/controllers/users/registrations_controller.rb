# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  def new
    session[:user_return_to] = params[:return_to] if params[:return_to].present?
    super
  end
end