class MoviesController < ApplicationController
    def show
        @movie = Movie.find_by!(name: params[:name])
        @reviews = Review.where(movie_id: @movie.id).includes(:user).order(created_at: :desc)
        
        if @reviews.any?
            total_score = @reviews.sum(&:rating)
            @average_rating = total_score / @reviews.size
        else
            @average_rating = 0
        end
    end

    def index
        @movies = Movie.all
    end
end