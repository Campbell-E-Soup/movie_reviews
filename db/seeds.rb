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
  { name: "Inception", description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom the project and his team to disaster.", release_year: 2010, genre_names: ["Action", "Sci-Fi"], poster: "inception.jpg" },
  { name: "The Godfather", description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.", release_year: 1972, genre_names: ["Drama"], poster: "godfather.jpg" },
  { name: "The Wizard of Oz", description: "Young Dorothy Gale and her dog Toto are swept away by a tornado from their Kansas farm to the magical Land of Oz and embark on a quest with three new friends to see the Wizard, who can return her to her home and fulfill the others' wishes.", release_year: 1939, genre_names: ["Fantasy"], poster: "wizardofoz.jpg" },
  { name: "Grand Hotel", description: "A group of very different individuals staying at a luxurious hotel in Berlin deal with each of their respective dramas.", release_year: 1932, genre_names: ["Drama"], poster: "grandhotel.jpg" },
  { name: "Rocky", description: "A small-time Philadelphia boxer gets a supremely rare chance to fight the world heavyweight champion in a bout in which he strives to go the distance for his self-respect.", release_year: 1976, genre_names: ["Drama"], poster: "rocky.jpg" },
  { name: "Indiana Jones and the Last Crusade", description: "In 1938, after his father goes missing while pursuing the Holy Grail, Indiana Jones finds himself up against the Nazis again to stop them from obtaining its powers.", release_year: 1989, genre_names: ["Action"], poster: "indianajones.png" },
  { name: "Star Wars: Episode IV - A New Hope", description: "Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire's world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth Vader.", release_year: 1977, genre_names: ["Action","Sci-Fi"], poster: "anewhope.jpg" },
  { name: "Battlefield Earth", description: "It's the year 3000 A.D., and the Earth is lost to the alien race of Psychlos. Humanity is enslaved by these gold-thirsty tyrants, who are unaware that their 'man-animals' are about to ignite the rebellion of a lifetime.", release_year: 2000, genre_names: ["Action","Sci-Fi"], poster: "battlefieldearth.jpg" },
  { name: "The Count of Monte Cristo", description: 'A young man, falsely imprisoned by his jealous "friend", escapes and uses a hidden treasure to exact his revenge.', release_year: 2002, genre_names: ["Drama"], poster: "countofmontecristo.jpg" },
  { name: "The Avengers", description: "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.", release_year: 2012, genre_names: ["Action","Sci-Fi"], poster: "avengers.jpg" },
  { name: "Nope", description: "The residents of a lonely gulch in inland California bear witness to an uncanny and chilling phenomenon.", release_year: 2022, genre_names: ["Horror","Sci-Fi"], poster: "nope.jpg" }
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
