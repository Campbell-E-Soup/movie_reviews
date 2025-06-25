class HomeController < ApplicationController
    def index
        @feed = Review.includes(:user, :movie).order(created_at: :desc).limit(5)
    end
end
