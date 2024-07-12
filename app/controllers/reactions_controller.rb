# app/controllers/reactions_controller.rb
class ReactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reactions = Reaction.all
  end

  def show
    @reaction = Reaction.find(params[:id])
  end

  def elements
    @reaction = Reaction.find(params[:id])
    @elements = @reaction.reaction_elements.includes(:element).map(&:element)

    respond_to do |format|
      format.html { render plain: "Not Found", status: :not_found }
      format.json { render json: @elements }
    end
  end
end
