class Xp < ApplicationRecord
  belongs_to :user

  def self.add_points(user, points)
    xp_record = Xp.find_or_create_by(user: user)
    xp_record.points ||= 0
    xp_record.points += points
    xp_record.save
  end
end
