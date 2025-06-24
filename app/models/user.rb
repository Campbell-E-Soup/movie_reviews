class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :profile_picture, dependent: :purge_later

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  def to_param
    username
  end

  before_create :set_join_date

  def set_join_date
    self.join_date ||= Date.today
  end
end
