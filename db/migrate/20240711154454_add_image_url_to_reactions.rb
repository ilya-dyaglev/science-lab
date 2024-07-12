class AddImageUrlToReactions < ActiveRecord::Migration[7.1]
  def change
    add_column :reactions, :image_url, :string
  end
end
