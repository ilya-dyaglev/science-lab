class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer_choice

  validates :is_correct, inclusion: { in: [true, false] }
end
