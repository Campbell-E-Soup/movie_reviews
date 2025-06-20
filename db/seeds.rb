Movie.destroy_all
Genre.destroy_all


# Create genres
genres = %w[Action Comedy Drama Horror Sci-Fi Fantasy].map do |name|
  Genre.create!(name: name)
end

# Helper to load poster file
def load_poster(filename)
  File.open(Rails.root.join("db/seeds/images/#{filename}"))
end

# Create movie data
movies = [
  { name: "Inception", description: "A mind-bending thriller", release_year: 2010, genre_names: ["Action", "Sci-Fi"], poster: "inception.jpg" },
  { name: "The Godfather", description: "Classic mafia story", release_year: 1972, genre_names: ["Drama"], poster: "godfather.jpg" },
  { name: "The Wizard of Oz", description: "A wonderful classic", release_year: 1939, genre_names: ["Fantasy"], poster: "wizardofoz.jpg" },
  { name: "Grand Hotel", description: "An academy award winning drama", release_year: 1932, genre_names: ["Drama"], poster: "grandhotel.jpg" },
  { name: "Rocky", description: "A classic inspiring sports movie", release_year: 1976, genre_names: ["Drama"], poster: "rocky.jpg" },
  { name: "Indiana Jones and the Last Crusade", description: "An action packed globetrotting adventure", release_year: 1989, genre_names: ["Action"], poster: "indianajones.png" },
  { name: "Star Wars: Episode IV - A New Hope", description: "The landmark science fiction adventure", release_year: 1977, genre_names: ["Action","Sci-Fi"], poster: "anewhope.jpg" },
  { name: "Battlefield Earth", description: "The legendary sci-fi dud", release_year: 2000, genre_names: ["Action","Sci-Fi"], poster: "battlefieldearth.jpg" },
  { name: "The Count of Monte Cristo", description: "An adaption of Alexandre Dumas 1846 classic", release_year: 2002, genre_names: ["Drama"], poster: "countofmontecristo.jpg" },
  { name: "The Avengers", description: "A superhero classic", release_year: 2010, genre_names: ["Action","Sci-Fi"], poster: "avengers.jpg" },
  { name: "Nope", description: "A UFO horror story", release_year: 2022, genre_names: ["Horror","Sci-Fi"], poster: "nope.jpg" }
]

movies.each do |movie_data|
  movie = Movie.create!(
    name: movie_data[:name],
    description: movie_data[:description],
    release_year: movie_data[:release_year]
  )

  movie.genres = genres.select { |g| movie_data[:genre_names].include?(g.name) }

  # Attach poster using Active Storage
  movie.poster.attach(
    io: load_poster(movie_data[:poster]),
    filename: movie_data[:poster],
    content_type: "image/jpeg"
  )
end
