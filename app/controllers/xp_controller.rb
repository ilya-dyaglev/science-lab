class XpController < ApplicationController
  def current
    xp_record = Xp.find_or_create_by(user: current_user)
    render json: { points: xp_record.points || 0, maxPoints: 1000 }
  end
end
