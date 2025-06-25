docker run -p 3000:3000 \
  -e RAILS_MASTER_KEY=your_master_key \
  -v $(pwd)/storage:/rails/storage \
  movie_reviews
