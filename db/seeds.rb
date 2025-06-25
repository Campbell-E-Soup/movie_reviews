Review.destroy_all
Movie.destroy_all
User.destroy_all
Genre.destroy_all


# Seed Genres
puts "Seeding genres..."
GENRE_MAP = Tmdb::Genre.movie_list.index_by(&:id)

GENRE_MAP.each_value do |genre|
  Genre.find_or_create_by!(name: genre.name)
end

puts "Genres seeded: #{Genre.count}"

# Seed Movies

# List of movies to seed
titles = [
  "Inception", "The Godfather", "The Wizard of Oz", "Grand Hotel", "Rocky",
  "Indiana Jones and the Last Crusade", "Star Wars: Episode IV - A New Hope",
  "Battlefield Earth", "The Count of Monte Cristo", "The Avengers", "Nope",
  "Iron Man", "The Holiday", "The Lord of the Rings: The Return of the King"
]

titles.each { |title| Movie.fetch_add_unique(title, genre_map: GENRE_MAP) }

puts "Finished seeding #{Movie.count} movies."

# Create Users

puts "Seeding users..."

users = [
  { username: "admin", email: "admin@example.com", password: "admin123", admin: true },
  { username: "campbellesoup", email: "campbellesoup@example.com", pfp: "souppfp.jpeg", password: "password123" },
  { username: "moviedave", email: "moviedave@example.com", password: "password123" },
  { username: "Cinema Or Not", email: "cinemaornot@example.com", pfp: "cinema.jpg", password: "cinema@123" }
]

# Helper to load pfps file
def load_photo(filename)
  File.open(Rails.root.join("db/seeds/images/#{filename}"))
end

users.each do |data|
  puts "Seeding user: #{data[:username]}"
  user = User.new(
    username: data[:username],
    email: data[:email],
    password: data[:password],
    password_confirmation: data[:password],
    admin: data[:admin] || false
  )

  if data[:pfp]
    path = Rails.root.join("db/seeds/images/#{data[:pfp]}")
    if File.exist?(path)
      user.profile_picture.attach(io: load_photo(data[:pfp]), filename: data[:pfp])
    end
  end

  user.save
end

puts "Finished seeding #{User.count} users."

# Create Reviews
reviews = [
  { user: "Cinema Or Not", movie: "Grand Hotel", rating: 4, text: "Cinema." },
  { user: "moviedave", movie: "Grand Hotel", rating: 2, text: "it was ok i guess" },
  { user: "campbellesoup", movie: "The Avengers", rating: 2, text: "I used to really like this movie when I came out. But my brothers watched this movie so much when we got it on DVD now whenever I think about watching I get nauseous. 2/5" },
  { user: "moviedave", movie: "The Avengers", rating: 5, text: "The best superhero movie." },
  { user: "moviedave", movie: "Battlefield Earth", rating: 5, text: "THE BEST MOVIE EVER MADE FIGHT ME" },
  { user: "campbellesoup", movie: "Battlefield Earth", rating: 1, text: "I wish I could give it a zero." },
  { user: "Cinema Or Not", movie: "Battlefield Earth", rating: 1, text: "Not Cinema" },
  { user: "campbellesoup", movie: "The Holiday", rating: 3, text: "It is my mom's favorite movie, it is ok." },
  { user: "Cinema Or Not", movie: "The Godfather", rating: 5, text: "Absolute Cinema" },
  { user: "Cinema Or Not", movie: "Nope", rating: 4, text: "Cinema" },
  { user: "campbellesoup", movie: "Iron Man", rating: 4, text: "With this and Batman Begins 2008 was a very good year for superhero movies." },
  { user: "moviedave", movie: "The Lord of the Rings: The Return of the King", rating: 2, text: "Not long enough." },
  { user: "Cinema Or Not", movie: "The Lord of the Rings: The Return of the King", rating: 5, text: "Absolute Cinema." },
  { user: "moviedave", movie: "Inception", rating: 3, text: "While a visually and conceptually interesting film it falls short compared to Nolan's later work. While the ending is very good I find that the general public's misinterpretation of it has devalued the emotional meaning of the ending. OK now back to brainrot.\nHurr Durr Tenet better." },
  { user: "moviedave", movie: "The Godfather", rating: 2, text: "It insists upon itself." },
  { user: "Cinema Or Not", movie: "Rocky", rating: 4, text: "Cinema" },
  { user: "Cinema Or Not", movie: "Nope", rating: 4, text: "Cinema" },
  { user: "campbellesoup", movie: "Grand Hotel", rating: 5, text: "One of my favorite films from the Golden Age of Hollywood." }
]

reviews.each do |data|
  user = User.find_by(username: data[:user])
  movie = Movie.find_by(name: data[:movie])

  next unless user && movie # skip if either not found

  Review.create!(
    user: user,
    movie: movie,
    rating: data[:rating],
    text: data[:text]
  )
  puts "Seeded #{data[:user]}'s review of #{data[:movie]}"
end

puts "Finished seeding #{Review.count} reviews."
puts "All done!"
