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

        @genres = @movie.genres
    end

    def index
        if params[:genre_name]
            @genre = Genre.find_by!(name: params[:genre_name])
            @movies = @genre.movies.includes(:genres)
        else
            @movies = Movie.includes(:genres).all
        end
    end
end