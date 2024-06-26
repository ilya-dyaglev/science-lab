class CreateReactionElements < ActiveRecord::Migration[7.1]
  def change
    create_table :reaction_elements do |t|
      t.references :reaction, null: false, foreign_key: true
      t.references :element, null: false, foreign_key: true
      t.string :role
      t.decimal :quantity

      t.timestamps
    end
  end
end
