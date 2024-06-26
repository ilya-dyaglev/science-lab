class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  before_destroy :clear_progress

  private

  def clear_progress
    UserLessonCompletion.where(user: user, lesson: course.lessons).destroy_all

    UserCourseCompletion.where(user: user, course: course).destroy_all

    course.lessons.each do |lesson|
      lesson.experiments.each do |experiment|
        experiment.questions.each do |question|
          Answer.where(user: user, question: question).destroy_all
        end
      end
    end

    Xp.where(user: user).destroy_all
  end
end
