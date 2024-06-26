class CreateExperimentResults < ActiveRecord::Migration[7.1]
  def change
    create_table :experiment_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :experiment, null: false, foreign_key: true
      t.text :result

      t.timestamps
    end
  end
end
