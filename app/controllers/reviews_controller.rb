class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def compose
    @movie = Movie.find_by!(name: params[:name])

    if @movie.nil?
      redirect_to movies_path, alert: "Movie not found."
      return
    end

    # Redirect if user already reviewed this movie
    if existing_review = Review.find_by(user: current_user, movie: @movie)
      redirect_to edit_by_movie_reviews_path(@movie.name)
      return
    end

    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:review][:movie_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.movie = @movie

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
    @review = Review.find(params[:id])

    if @review.user != current_user
      redirect_to root_path, alert: "You're not authorized to update this review."
      return
    end

    if @review.update(review_params)
      redirect_to movie_path(@review.movie), notice: "Review updated!"
    else
      @movie = @review.movie
      render :compose, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :text)
  end
end