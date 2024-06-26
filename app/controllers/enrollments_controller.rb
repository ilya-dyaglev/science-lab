class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    course = Course.find(params[:course_id])
    current_user.enrollments.create(course: course)
    redirect_to course_path(course), notice: 'Successfully enrolled in course.'
  end

  def destroy
    enrollment = current_user.enrollments.find(params[:id])
    enrollment.destroy
    redirect_to root_path, notice: 'Successfully unenrolled from course.'
  end
end
