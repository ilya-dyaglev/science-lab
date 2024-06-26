class Course < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :enrollments

  def completed_by?(user)
    lessons.all? { |lesson| lesson.completed_by?(user) }
  end

  def mark_as_completed(user)
    if completed_by?(user)
      UserCourseCompletion.find_or_create_by(user: user, course: self) do |completion|
        completion.completed_at = Time.current
      end
    end
  end

  def progress_for(user)
    total_lessons = lessons.count
    completed_lessons = lessons.select { |l| l.completed_by?(user) }.count
    return 0 if total_lessons.zero?
    (completed_lessons.to_f / total_lessons * 100).round(2)
  end
end
