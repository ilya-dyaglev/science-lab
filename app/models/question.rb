class Question < ApplicationRecord
  belongs_to :experiment
  has_many :answer_choices, dependent: :destroy
  has_many :answers

  serialize :options, JSON

  enum question_type: {single_choice: 'single_choice', multiple_choice: 'multiple_choice', word_bank: 'word_bank'}

  validates :content, :question_type, presence: true
  validate :validate_options

  def completed_by?(user)
    answers.where(user: user, is_correct: true).exists?
  end

  def completion_time(user)
    correct_answer = answers.find_by(user: user, is_correct: true)
    correct_answer.created_at if correct_answer
  end

  def validate_options
    if question_type == 'multiple_choice' || question_type == 'word_bank'
      if options.blank?
        errors.add(:options, "can't be blank")
      end
      if correct_option.blank?
        errors.add(:correct_option, "can't be blank")
      end
    end
  end
end
