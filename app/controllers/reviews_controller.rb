class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:update, :delete_via_link]
  before_action :authorize_destroy!, only: [:delete_via_link]

  def compose
    @movie = Movie.find_by!(name: params[:name])
    
    # Redirect if user already reviewed this movie
    if existing_review = Review.find_by(user: current_user, movie: @movie)
      redirect_to edit_by_movie_reviews_path(@movie.name) and return
    end

    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:review][:movie_id])
    @review = current_user.reviews.new(review_params.merge(movie: @movie))

    if @review.save
      redirect_to movie_path(@movie), notice: "Review submitted!"
    else
      render :compose, status: :unprocessable_entity
    end
  end

  def edit_by_movie
    @movie = Movie.find_by!(name: params[:name])
    @review = Review.find_by!(user: current_user, movie: @movie)
    render :compose
  end

  def update
    if @review.update(review_params)
      redirect_to movie_path(@review.movie), notice: "Review updated!"
    else
      @movie = @review.movie
      render :compose, status: :unprocessable_entity
    end
  end

  def delete_via_link
    @review.destroy
    redirect_back(fallback_location: root_path, notice: "Review deleted successfully.")
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def authorize_update!
    return if @review.user == current_user

    redirect_to root_path, alert: "You're not authorized to update this review."
  end

  def authorize_destroy!
    unless current_user == @review.user || current_user.admin?
      redirect_back(fallback_location: root_path, alert: "You are not authorized to delete this review.")
    end
  end

  def review_params
    params.require(:review).permit(:rating, :text)
  end
end