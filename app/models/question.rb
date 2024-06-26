class Question < ApplicationRecord
  belongs_to :experiment
  has_many :answer_choices, dependent: :destroy
  has_many :answers

  def completed_by?(user)
    answers.where(user: user, is_correct: true).exists?
  end

  def completion_time(user)
    correct_answer = answers.find_by(user: user, is_correct: true)
    correct_answer.created_at if correct_answer
  end
end
