class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :poster, dependent: :purge_later

  has_and_belongs_to_many :genres

  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end

  # Add movie from TMDB
  def self.fetch_add_unique(title, verbose: true, genre_map: nil)
    results = Tmdb::Search.movie(title).results
    return -1 if results.empty?

    genre_map ||= Tmdb::Genre.movie_list.index_by(&:id) # Avoid multiple calls when seeding but do not quote me on that

    data = results.first
    normalized_title = data.title.to_s.parameterize

    if Movie.all.any? { |m| m.name.to_s.parameterize == normalized_title }
      puts "Skipped duplicate: #{data.title}" if verbose
      return 0
    end

    puts "Seeding movie: #{data.title}" if verbose

    begin
      Movie.transaction do
        movie = Movie.create!(
          name: data.title,
          description: Tmdb::Movie.detail(data.id).overview,
          release_year: data.release_date&.to_date&.year
        )

        genre_names = data.genre_ids.map { |id| genre_map[id]&.name }.compact
        movie.genres = Genre.where(name: genre_names)

        if data.poster_path
          file = URI.open("https://image.tmdb.org/t/p/w500#{data.poster_path}")
          movie.poster.attach(io: file, filename: "#{data.title.parameterize}.jpg", content_type: "image/jpeg")
        end
      end
    rescue => e
      puts "Failed to seed movie #{data.title}: #{e.message}" # Should always output even if not verbose
      return -2
    end

    1
  end
end
