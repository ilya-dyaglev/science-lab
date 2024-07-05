class MakeAnswerChoiceIdNullableInAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :answers, :answer_choice_id, true
  end
end
