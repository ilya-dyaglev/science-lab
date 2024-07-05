class AddTypeAndOptionsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :question_type, :string
    add_column :questions, :options, :text
    add_column :questions, :correct_option, :string
  end
end
