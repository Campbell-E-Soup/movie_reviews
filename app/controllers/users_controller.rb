class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def logout
    sign_out current_user
    redirect_to root_path, notice: "Logged out successfully."
  end
end
