class CreateGenresMoviesJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :genres, :movies do |t|
      t.index [:genre_id, :movie_id], unique: true

      t.index :genre_id
      t.index :movie_id
    end
  end
end
