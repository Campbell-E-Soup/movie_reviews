class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def compose
    @movie = Movie.find_by(name: params[:name])

    if @movie.nil?
      redirect_to movies_path, alert: "Movie not found."
      return
    end

    @review = Review.new
    render :compose
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

  private

  def review_params
    params.require(:review).permit(:rating, :text)
  end
end