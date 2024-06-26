class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_enrollment, only: [:show]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons
  end

  private

  def check_enrollment
    @course = Course.find(params[:id])
    unless current_user.enrolled_in?(@course)
      redirect_to root_path, alert: 'You must enroll in the course to view its content.'
    end
  end
end
