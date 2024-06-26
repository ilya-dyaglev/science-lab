class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find(params[:question_id])
    answer_choice = AnswerChoice.find(params[:answer_choice_id])
    answer = Answer.create!(user: current_user, question: question, answer_choice: answer_choice, is_correct: answer_choice.correct)

    if answer_choice.correct?
      flash[:notice] = "Correct answer! Congratulations! Completed on #{answer.created_at.strftime('%Y-%m-%d %H:%M:%S')}"
      Xp.add_points(current_user, 10) # Add XP for correct answer
      check_completion_status(question.experiment, current_user)
    else
      flash[:alert] = 'Incorrect answer, please try again.'
    end

    redirect_to experiment_path(question.experiment)
  end

  private

  def check_completion_status(experiment, user)
    if experiment.completed_by?(user)
      flash[:notice] = 'Experiment completed!'
      Xp.add_points(user, 50) # Add XP for completing an experiment
      experiment.lesson.mark_as_completed(user)
      check_lesson_completion(experiment.lesson, user)
    end
  end

  def check_lesson_completion(lesson, user)
    if lesson.completed_by?(user)
      flash[:notice] = 'Lesson completed!'
      Xp.add_points(user, 100) # Add XP for completing a lesson
      lesson.course.mark_as_completed(user)
      check_course_completion(lesson.course, user)
    end
  end

  def check_course_completion(course, user)
    if course.completed_by?(user)
      flash[:notice] = 'Course completed!'
      Xp.add_points(user, 200) # Add XP for completing a course
    end
  end
end
