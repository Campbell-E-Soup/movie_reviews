class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def logout
    sign_out current_user
    redirect_to root_path, notice: "Logged out successfully."
  end

  def show
    @user = User.find_by!(username: params[:username])
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_user_not_found

  private

  def render_user_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
