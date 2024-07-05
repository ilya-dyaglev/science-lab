class UsersController < ApplicationController
  def profile
    @user = current_user
    @badges = @user.badges
  end
end
