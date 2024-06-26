class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @enrolled_courses = current_user.courses
    @available_courses = Course.where.not(id: @enrolled_courses.pluck(:id))
  end
end
