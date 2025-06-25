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
    @reviews = Review.where(user_id: @user.id).includes(:movie).order(created_at: :desc)
  end

  before_action :set_user, only: [ :show, :update_profile_picture ]

  def update_profile_picture
    if params[:user]&.[](:profile_picture).present?
      @user.profile_picture.purge if @user.profile_picture.attached?
      @user.profile_picture.attach(params[:user][:profile_picture])
    else
      flash[:alert] = "Please select a file to upload."
    end
    redirect_to @user
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_user_not_found

  private

  def render_user_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def set_user
    @user = User.find_by!(username: params[:username])
  end
end
