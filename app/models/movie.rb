class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :poster, dependent: :purge_later

  has_and_belongs_to_many :genres

  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end
end