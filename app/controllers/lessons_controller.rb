class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_enrollment

  def show
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
    @experiments = @lesson.experiments
  end

  private

  def check_enrollment
    @course = Course.find(params[:course_id])
    unless current_user.enrolled_in?(@course)
      redirect_to root_path, alert: 'You must enroll in the course to view its content.'
    end
  end
end
