class CreateAnswerChoices < ActiveRecord::Migration[7.1]
  def change
    create_table :answer_choices do |t|
      t.references :question, null: false, foreign_key: true
      t.text :content
      t.boolean :correct

      t.timestamps
    end
  end
end
