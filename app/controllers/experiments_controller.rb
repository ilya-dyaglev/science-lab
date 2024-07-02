class ExperimentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @experiment = Experiment.find(params[:id])
    @questions = @experiment.questions
    @elements = Element.all
    @reactions = @experiment.reactions
  end

  def combine
    elements = params[:elements]

    if elements.blank?
      render json: { result: "Please enter quantities for elements before combining." }
      return
    end

    combined_result = find_combination(elements)
    if combined_result
      render json: { result: "Reaction Result: #{combined_result}" }
    else
      render json: { result: "No known chemical reaction for the selected elements." }
    end
  end

  private

  def find_combination(selected_elements)
    reactions = Reaction.includes(:reaction_elements).all

    reactions.each do |reaction|
      reaction_elements = reaction.reaction_elements.map do |re|
        { name: re.element.name, quantity: re.quantity }
      end

      Rails.logger.debug "Selected Elements: #{selected_elements}"
      Rails.logger.debug "Reaction Elements: #{reaction_elements}"

      return reaction.name if match_elements(selected_elements, reaction_elements)
    end
    nil
  end

  def match_elements(selected_elements, reaction_elements)
    return false if selected_elements.length != reaction_elements.length

    sorted_selected = selected_elements.sort_by { |e| e["elementName"] }
    sorted_reaction = reaction_elements.sort_by { |e| e[:name] }

    sorted_selected.each_with_index do |selected, index|
      if selected["elementName"] != sorted_reaction[index][:name] || selected["quantity"] != sorted_reaction[index][:quantity]
        return false
      end
    end
    true
  end
end
