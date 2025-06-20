class MoviesController < ApplicationController
    def show
        @movie = Movie.find_by!(name: params[:name])
    end

    def index
        @movies = Movie.all
    end
end