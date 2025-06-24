module Admin
    class Admin::DashboardController < Admin::BaseController
        before_action :set_movie, only: [:delete_movie_via_link]

        def index
            # I was originally going to use chartkick to make charts and stuff but I could not make it work well
            @review_count = Review.count
            @movie_count = Movie.count
            @user_count = User.count
            @top_move = Movie
                .left_joins(:reviews)
                .group('movies.id')
                .order('COUNT(reviews.id) DESC')
                .first
            @top_user = User
                .left_joins(:reviews)
                .group('users.id')
                .order('COUNT(reviews.id) DESC')
                .first
            @worst_movie = Movie
                .joins(:reviews)
                .group(:id)
                .order('AVG(reviews.rating) ASC')
                .first
        end

        def users

        end

        def movies
            @movies = Movie.includes(:genres).order(created_at: :desc)
        end

        def reviews
            @reviews = Review.includes(:user).order(created_at: :desc)
        end

        def delete_movie_via_link
            @movie.destroy
            redirect_back fallback_location: admin_movies_path, notice: "Movie deleted successfully."
        end

        private

        def set_movie
            @movie = Movie.find_by!(name: params[:id])
        end
    end
end
