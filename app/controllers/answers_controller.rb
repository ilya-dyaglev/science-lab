class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find(params[:question_id])

    case question.question_type
    when 'single_choice'
      handle_single_choice(question)
    when 'multiple_choice'
      handle_multiple_choice(question)
    when 'word_bank'
      handle_word_bank(question)
    else
      flash[:alert] = 'Unknown question type.'
      redirect_to experiment_path(question.experiment) and return
    end
  end

  private

  def handle_single_choice(question)
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

  def handle_multiple_choice(question)
    selected_choice_ids = params[:answer_choice_ids] || []
    if selected_choice_ids.empty?
      flash[:alert] = 'Please select at least one answer.'
      redirect_to experiment_path(question.experiment) and return
    end

    selected_choices = AnswerChoice.where(id: selected_choice_ids)
    correct_choices = question.answer_choices.where(correct: true)

    is_correct = (selected_choices.map(&:id).sort == correct_choices.map(&:id).sort)
    selected_choices.each do |choice|
      Answer.create!(user: current_user, question: question, answer_choice: choice, is_correct: is_correct)
    end

    if is_correct
      flash[:notice] = "Correct answer! Congratulations! Completed on #{Time.current.strftime('%Y-%m-%d %H:%M:%S')}"
      Xp.add_points(current_user, 10) # Add XP for correct answer
      check_completion_status(question.experiment, current_user)
    else
      flash[:alert] = 'Incorrect answer, please try again.'
    end

    redirect_to experiment_path(question.experiment)
  end

  def handle_word_bank(question)
    correct = true
    user_answers = []

    # Guard clause for nil or empty values
    question.options.each_with_index do |option, index|
      user_answer = params["question_#{question.id}_option_#{index}"]
      if user_answer.nil? || user_answer.strip.empty?
        flash[:alert] = 'Please fill in all the blanks.'
        redirect_to experiment_path(question.experiment) and return
      end
      correct &= (user_answer == option)
      user_answers << user_answer
    end

    Answer.create!(user: current_user, question: question, content: user_answers.join(','), is_correct: correct)

    if correct
      flash[:notice] = "Correct answer! Congratulations! Completed on #{Time.current.strftime('%Y-%m-%d %H:%M:%S')}"
      Xp.add_points(current_user, 10) # Add XP for correct answer
      check_completion_status(question.experiment, current_user)
    else
      flash[:alert] = 'Incorrect answer, please try again.'
    end

    redirect_to experiment_path(question.experiment)
  end

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
