class User < ApplicationRecord
    has_one_attached :profile_picture
    # Auth
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
