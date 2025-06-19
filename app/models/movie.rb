class Movie < ApplicationRecord
  has_one_attached :poster

  has_and_belongs_to_many :genres
end