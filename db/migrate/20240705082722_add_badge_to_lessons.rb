class AddBadgeToLessons < ActiveRecord::Migration[7.1]
  def change
    add_reference :lessons, :badge, null: true, foreign_key: true
  end
end
