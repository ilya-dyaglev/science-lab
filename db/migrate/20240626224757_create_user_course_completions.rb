class CreateUserCourseCompletions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_course_completions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
