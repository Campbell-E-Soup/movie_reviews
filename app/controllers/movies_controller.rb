class MoviesController < ApplicationController
    def show
        @movie = Movie.find_by!(name: params[:name])
        @reviews = Review.where(movie_id: @movie.id).includes(:user).order(created_at: :desc)
    end

    def index
        @movies = Movie.all
    end
end