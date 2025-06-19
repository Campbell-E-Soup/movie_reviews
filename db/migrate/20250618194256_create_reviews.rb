class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.decimal :rating, precision: 3, scale: 2, null: false
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
