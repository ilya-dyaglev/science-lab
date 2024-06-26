class Experiment < ApplicationRecord
  belongs_to :lesson
  has_many :questions, dependent: :destroy

  def completed_by?(user)
    questions.all? { |question| question.completed_by?(user) }
  end

  def progress_for(user)
    total_questions = questions.count
    completed_questions = questions.select { |q| q.completed_by?(user) }.count
    return 0 if total_questions.zero?
    (completed_questions.to_f / total_questions * 100).round(2)
  end
end
