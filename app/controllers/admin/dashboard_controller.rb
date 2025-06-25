module Admin
    class Admin::DashboardController < Admin::BaseController
        before_action :set_movie, only: [ :delete_movie_via_link ]

        def index
            # I was originally going to use chartkick to make charts and stuff but I could not make it work well so here are some basic stats
            @review_count = Review.count
            @movie_count = Movie.count
            @user_count = User.count
            @top_move = Movie
                .left_joins(:reviews)
                .group("movies.id")
                .order("COUNT(reviews.id) DESC")
                .first
            @top_user = User
                .left_joins(:reviews)
                .group("users.id")
                .order("COUNT(reviews.id) DESC")
                .first
            @worst_movie = Movie
                .joins(:reviews)
                .group(:id)
                .order("AVG(reviews.rating) ASC")
                .first
        end

        def users
            @users = User.all
        end

        def movies
            @movies = Movie.includes(:genres).order(created_at: :desc)
        end

        def reviews
            @reviews = Review.includes(:user).order(created_at: :desc)
        end

        def delete_movie_via_link # Delete movie from database
            @movie.destroy
            redirect_back fallback_location: admin_movies_path, notice: "Movie deleted successfully."
        end

        def create_movie # Load movie in from TMDB if not in database already
            title = params[:movie_title].to_s.strip

            case Movie.fetch_add_unique(title, verbose: false)
            when 1
                flash[:notice] = "Added movie '#{title}' to database successfully."
            when 0
                flash[:alert] = "Movie already exists."
            when -1
                flash[:alert] = "Could not find movie with name '#{title}'"
            when -2
                flash[:alert] = "An error occured and the transaction failed."
            end

            redirect_to admin_movies_path
        end

        def update_movie
            name = params[:name].to_s
            movie = Movie.find_by!(name: name)

            results = Tmdb::Search.movie(movie.name).results
            if results.empty?
                flash[:alert] = "Movie not found on TMDb. Movie must no longer exist."
                return redirect_to admin_movies_path
            end

            data = results.first
            genre_map = Tmdb::Genre.movie_list.index_by(&:id)

            begin
                Movie.transaction do
                    movie.update!(
                        name: data.title,
                        description: Tmdb::Movie.detail(data.id).overview,
                        release_year: data.release_date&.to_date&.year
                    )

                    genre_names = data.genre_ids.map { |id| genre_map[id]&.name }.compact
                    movie.genres = Genre.where(name: genre_names)

                    if data.poster_path
                        file = URI.open("https://image.tmdb.org/t/p/w500#{data.poster_path}")
                        movie.poster.purge if movie.poster.attached?
                        movie.poster.attach(io: file, filename: "#{data.title.parameterize}.jpg", content_type: "image/jpeg")
                    end
                end

                flash[:notice] = "Movie '#{movie.name}' updated successfully."

            rescue => e
                flash[:alert] = "Failed to update movie: #{e.message}"
            end

            redirect_to admin_movies_path
        end

        def delete_profile_picture
            user = User.find_by!(username: params[:username])

            if user.profile_picture.attached?
                user.profile_picture.purge
                flash[:notice] = "Profile picture deleted for #{user.username}."
            else
                flash[:alert] = "No profile picture to delete."
            end

            redirect_to admin_users_path
        end

        def destroy_user
            user = User.find_by!(username: params[:username])
            username = user.username

            user.destroy
            flash[:notice] = "User #{username} deleted successfully."

            redirect_to admin_users_path
        end

        private

        def set_movie
            @movie = Movie.find_by!(name: params[:id])
        end
    end
end
