class AddSymbolToReactions < ActiveRecord::Migration[7.1]
  def change
    add_column :reactions, :symbol, :string
  end
end
