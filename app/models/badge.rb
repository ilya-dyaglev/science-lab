class Badge < ApplicationRecord
  has_one_attached :image
  has_many :user_badges
  has_many :users, through: :user_badges
end
