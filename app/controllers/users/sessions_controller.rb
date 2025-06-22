class Users::SessionsController < Devise::SessionsController
  def new
    session[:user_return_to] = params[:return_to] if params[:return_to].present?
    super
  end
end