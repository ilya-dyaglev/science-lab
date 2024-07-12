class AddElementsymbolToReactionElements < ActiveRecord::Migration[7.1]
  def change
    add_column :reaction_elements, :element_symbol, :string
  end
end
