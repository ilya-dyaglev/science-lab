class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer_choice, optional: true

  validates :content, presence: true, if: -> { answer_choice.nil? }
end
