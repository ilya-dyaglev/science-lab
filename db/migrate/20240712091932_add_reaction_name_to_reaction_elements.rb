class AddReactionNameToReactionElements < ActiveRecord::Migration[7.1]
  def change
    add_column :reaction_elements, :reaction_name, :string
  end
end
