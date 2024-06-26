class CreateElements < ActiveRecord::Migration[7.1]
  def change
    create_table :elements do |t|
      t.string :name
      t.string :symbol
      t.integer :atomic_number
      t.decimal :atomic_weight
      t.integer :period
      t.integer :group
      t.string :category
      t.bigint :state_at_room_temp
      t.decimal :density
      t.decimal :melting_point
      t.decimal :boiling_point

      t.timestamps
    end
  end
end
