class ExperimentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @experiment = Experiment.find(params[:id])
    @questions = @experiment.questions
  end
end
