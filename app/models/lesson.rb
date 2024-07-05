class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :badge, optional: true
  has_many :experiments, dependent: :destroy


  def completed_by?(user)
    experiments.all? { |experiment| experiment.completed_by?(user) }
  end

  def mark_as_completed(user)
    if completed_by?(user)
      UserLessonCompletion.find_or_create_by(user: user, lesson: self) do |completion|
        completion.completed_at = Time.current
      end
      award_badge(user) if badge.present?
    end
  end

  def progress_for(user)
    total_experiments = experiments.count
    completed_experiments = experiments.select { |e| e.completed_by?(user) }.count
    return 0 if total_experiments.zero?
    (completed_experiments.to_f / total_experiments * 100).round(2)
  end

  private

  def award_badge(user)
    user_badge = UserBadge.find_or_create_by(user: user, badge: badge)
    user_badge.update(awarded_at: Time.current)
  end

end
