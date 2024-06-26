class AddAnswerChoiceToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_reference :answers, :answer_choice, null: false, foreign_key: true
  end
end
