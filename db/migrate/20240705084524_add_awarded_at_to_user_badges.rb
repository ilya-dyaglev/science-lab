class AddAwardedAtToUserBadges < ActiveRecord::Migration[7.1]
  def change
    add_column :user_badges, :awarded_at, :datetime
  end
end
