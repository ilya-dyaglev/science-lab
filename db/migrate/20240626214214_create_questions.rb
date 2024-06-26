class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :experiment, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
