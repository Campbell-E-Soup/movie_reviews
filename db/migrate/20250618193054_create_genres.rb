class CreateGenres < ActiveRecord::Migration[8.0]
  def change
    create_table :genres do |t|
      t.string :name, limit: 15

      t.timestamps
    end
  end
end
