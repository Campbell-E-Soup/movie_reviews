class Movie < ApplicationRecord
  has_one_attached :poster

  has_and_belongs_to_many :genres

  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end
end