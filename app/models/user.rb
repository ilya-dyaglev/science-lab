class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :xps
  has_many :user_badges
  has_many :badges, through: :user_badges

  def total_xp
    xps.sum(:points)
  end

  def enrolled_in?(course)
    courses.include?(course)
  end
end
