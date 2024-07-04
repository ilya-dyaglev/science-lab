# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_04_185946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "content"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answer_choices_on_question_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.text "content"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "answer_choice_id", null: false
    t.index ["answer_choice_id"], name: "index_answers_on_answer_choice_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "badges", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elements", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.integer "atomic_number"
    t.decimal "atomic_weight"
    t.integer "period"
    t.integer "group"
    t.string "category"
    t.bigint "state_at_room_temp"
    t.decimal "density"
    t.decimal "melting_point"
    t.decimal "boiling_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "experiment_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "experiment_id", null: false
    t.text "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experiment_id"], name: "index_experiment_results_on_experiment_id"
    t.index ["user_id"], name: "index_experiment_results_on_user_id"
  end

  create_table "experiments", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.string "title"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_experiments_on_lesson_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "experiment_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experiment_id"], name: "index_questions_on_experiment_id"
  end

  create_table "reaction_elements", force: :cascade do |t|
    t.bigint "reaction_id", null: false
    t.bigint "element_id", null: false
    t.string "role"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_reaction_elements_on_element_id"
    t.index ["reaction_id"], name: "index_reaction_elements_on_reaction_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_badges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "user_course_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_course_completions_on_course_id"
    t.index ["user_id"], name: "index_user_course_completions_on_user_id"
  end

  create_table "user_lesson_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_user_lesson_completions_on_lesson_id"
    t.index ["user_id"], name: "index_user_lesson_completions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.text "bio"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "xps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_xps_on_user_id"
  end

  add_foreign_key "answer_choices", "questions"
  add_foreign_key "answers", "answer_choices"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "experiment_results", "experiments"
  add_foreign_key "experiment_results", "users"
  add_foreign_key "experiments", "lessons"
  add_foreign_key "lessons", "courses"
  add_foreign_key "questions", "experiments"
  add_foreign_key "reaction_elements", "elements"
  add_foreign_key "reaction_elements", "reactions"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
  add_foreign_key "user_course_completions", "courses"
  add_foreign_key "user_course_completions", "users"
  add_foreign_key "user_lesson_completions", "lessons"
  add_foreign_key "user_lesson_completions", "users"
  add_foreign_key "xps", "users"
end
