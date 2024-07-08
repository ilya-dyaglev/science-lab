puts "Deleting all existing data..."
Answer.delete_all
AnswerChoice.delete_all
Question.delete_all
Experiment.delete_all
UserLessonCompletion.delete_all
Lesson.delete_all
Enrollment.delete_all
Course.delete_all
UserBadge.delete_all
Badge.delete_all
Xp.delete_all
User.delete_all
ReactionElement.delete_all
Element.delete_all

puts "Creating new data..."

puts 'Creating courses...'
course1 = Course.create!(title: 'Chemistry 101', description: 'An introductory course to Chemistry.')
course2 = Course.create!(title: 'Advanced Chemistry', description: 'A deeper dive into Chemistry concepts.')

puts 'Creating lessons...'
lessons_course1 = [
  { title: 'Chemistry Basics', content: 'Introduction to the basics of Chemistry.' },
  { title: 'Atoms and Molecules', content: 'Understanding atoms and molecules.' },
  { title: 'Periodic Table', content: 'Introduction to the Periodic Table of elements.' },
  { title: 'Chemical Bonds', content: 'Understanding different types of chemical bonds.' },
  { title: 'States of Matter', content: 'Study of solids, liquids, and gases.' },
  { title: 'Solutions and Mixtures', content: 'Introduction to solutions and mixtures.' }
]

lessons_course2 = [
  { title: 'Chemical Reactions', content: 'Detailed study of chemical reactions.' },
  { title: 'Organic Chemistry', content: 'Study of organic compounds.' },
  { title: 'Acids and Bases', content: 'Understanding acids and bases.' },
  { title: 'Thermochemistry', content: 'Study of heat in chemical reactions.' },
  { title: 'Electrochemistry', content: 'Study of chemical processes that cause electrons to move.' }
]

lessons_course1.each do |lesson_attrs|
  Lesson.create!(course: course1, **lesson_attrs)
end

lessons_course2.each do |lesson_attrs|
  Lesson.create!(course: course2, **lesson_attrs)
end

puts 'Creating experiments...'
experiments = [
  { lesson_title: 'Chemistry Basics', title: 'Experiment 1: Water Formation', instructions: 'Mix hydrogen and oxygen to form water.' },
  { lesson_title: 'Atoms and Molecules', title: 'Experiment 2: Hydrogen Chloride Formation', instructions: 'Mix hydrogen and chlorine to form hydrochloric acid.' },
  { lesson_title: 'Periodic Table', title: 'Experiment 3: Sodium Chloride Formation', instructions: 'Mix sodium and chlorine to form sodium chloride.' },
  { lesson_title: 'Chemical Bonds', title: 'Experiment 4: Ammonia Formation', instructions: 'Mix nitrogen and hydrogen to form ammonia.' },
  { lesson_title: 'States of Matter', title: 'Experiment 5: Carbon Dioxide Formation', instructions: 'Mix carbon and oxygen to form carbon dioxide.' },
  { lesson_title: 'Solutions and Mixtures', title: 'Experiment 6: Copper Sulfate Formation', instructions: 'Mix copper and sulfur to form copper sulfate.' },
  { lesson_title: 'Chemical Reactions', title: 'Experiment 7: Calcium Hydroxide Formation', instructions: 'Mix calcium and water to form calcium hydroxide.' },
  { lesson_title: 'Organic Chemistry', title: 'Experiment 8: Ethanol Formation', instructions: 'Mix ethene and water to form ethanol.' },
  { lesson_title: 'Acids and Bases', title: 'Experiment 9: Sulfuric Acid Formation', instructions: 'Mix sulfur dioxide and water to form sulfuric acid.' },
  { lesson_title: 'Thermochemistry', title: 'Experiment 10: Methane Combustion', instructions: 'Mix methane and oxygen to form carbon dioxide and water.' },
  { lesson_title: 'Electrochemistry', title: 'Experiment 11: Sodium Hydroxide Formation', instructions: 'Mix sodium and water to form sodium hydroxide.' }
]

experiments.each do |experiment_attrs|
  lesson = Lesson.find_by(title: experiment_attrs[:lesson_title])
  Experiment.create!(lesson: lesson, title: experiment_attrs[:title], instructions: experiment_attrs[:instructions])
end

puts 'Creating elements...'
elements = [
  { name: 'Hydrogen', symbol: 'H', atomic_number: 1, atomic_weight: 1.008, period: 1, group: 1, category: 'Nonmetal', state_at_room_temp: 1, density: 0.00008988, melting_point: -259.14, boiling_point: -252.87 },
  { name: 'Helium', symbol: 'He', atomic_number: 2, atomic_weight: 4.002602, period: 1, group: 18, category: 'Noble Gas', state_at_room_temp: 1, density: 0.0001785, melting_point: -272.20, boiling_point: -268.93 },
  { name: 'Carbon', symbol: 'C', atomic_number: 6, atomic_weight: 12.011, period: 2, group: 14, category: 'Nonmetal', state_at_room_temp: 2, density: 2.267, melting_point: 3550, boiling_point: 4027 },
  { name: 'Oxygen', symbol: 'O', atomic_number: 8, atomic_weight: 15.999, period: 2, group: 16, category: 'Nonmetal', state_at_room_temp: 1, density: 0.001429, melting_point: -218.79, boiling_point: -182.95 },
  { name: 'Nitrogen', symbol: 'N', atomic_number: 7, atomic_weight: 14.007, period: 2, group: 15, category: 'Nonmetal', state_at_room_temp: 1, density: 0.0012506, melting_point: -210.1, boiling_point: -195.79 },
  { name: 'Chlorine', symbol: 'Cl', atomic_number: 17, atomic_weight: 35.45, period: 3, group: 17, category: 'Halogen', state_at_room_temp: 1, density: 0.003214, melting_point: -101.5, boiling_point: -34.04 },
  { name: 'Sodium', symbol: 'Na', atomic_number: 11, atomic_weight: 22.99, period: 3, group: 1, category: 'Alkali Metal', state_at_room_temp: 2, density: 0.968, melting_point: 97.72, boiling_point: 883 },
  { name: 'Sulfur', symbol: 'S', atomic_number: 16, atomic_weight: 32.06, period: 3, group: 16, category: 'Nonmetal', state_at_room_temp: 2, density: 2.067, melting_point: 115.21, boiling_point: 444.6 },
  { name: 'Calcium', symbol: 'Ca', atomic_number: 20, atomic_weight: 40.078, period: 4, group: 2, category: 'Alkaline Earth Metal', state_at_room_temp: 2, density: 1.54, melting_point: 842, boiling_point: 1484 },
  { name: 'Copper', symbol: 'Cu', atomic_number: 29, atomic_weight: 63.546, period: 4, group: 11, category: 'Transition Metal', state_at_room_temp: 2, density: 8.96, melting_point: 1084.62, boiling_point: 2562 }
]

elements.each do |element_attrs|
  Element.create!(element_attrs)
end

puts 'Creating reactions...'
reactions = [
  { name: 'Water Formation', description: 'Hydrogen reacts with oxygen to form water.' },
  { name: 'Hydrogen Chloride Formation', description: 'Hydrogen reacts with chlorine to form hydrochloric acid.' },
  { name: 'Sodium Chloride Formation', description: 'Sodium reacts with chlorine to form sodium chloride.' },
  { name: 'Ammonia Formation', description: 'Nitrogen reacts with hydrogen to form ammonia.' },
  { name: 'Carbon Dioxide Formation', description: 'Carbon reacts with oxygen to form carbon dioxide.' },
  { name: 'Copper Sulfate Formation', description: 'Copper reacts with sulfur to form copper sulfate.' },
  { name: 'Calcium Hydroxide Formation', description: 'Calcium reacts with water to form calcium hydroxide.' },
  { name: 'Ethanol Formation', description: 'Ethene reacts with water to form ethanol.' },
  { name: 'Sulfuric Acid Formation', description: 'Sulfur dioxide reacts with water to form sulfuric acid.' },
  { name: 'Methane Combustion', description: 'Methane reacts with oxygen to form carbon dioxide and water.' },
  { name: 'Sodium Hydroxide Formation', description: 'Sodium reacts with water to form sodium hydroxide.' }
]

reactions.each do |reaction_attrs|
  Reaction.create!(reaction_attrs)
end

puts 'Creating reaction elements...'
reaction_elements = [
  { reaction_name: 'Water Formation', element_symbol: 'H', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Water Formation', element_symbol: 'O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Water Formation', element_symbol: 'H2O', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Hydrogen Chloride Formation', element_symbol: 'H', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Hydrogen Chloride Formation', element_symbol: 'Cl', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Hydrogen Chloride Formation', element_symbol: 'HCl', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Sodium Chloride Formation', element_symbol: 'Na', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Chloride Formation', element_symbol: 'Cl', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Chloride Formation', element_symbol: 'NaCl', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Ammonia Formation', element_symbol: 'N', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Ammonia Formation', element_symbol: 'H', role: 'Reactant', quantity: 3.0 },
  { reaction_name: 'Ammonia Formation', element_symbol: 'NH3', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'C', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'O', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'CO2', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Copper Sulfate Formation', element_symbol: 'Cu', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Copper Sulfate Formation', element_symbol: 'S', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Copper Sulfate Formation', element_symbol: 'CuS', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Calcium Hydroxide Formation', element_symbol: 'Ca', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Calcium Hydroxide Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Calcium Hydroxide Formation', element_symbol: 'Ca(OH)2', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Ethanol Formation', element_symbol: 'C2H4', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Ethanol Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Ethanol Formation', element_symbol: 'C2H5OH', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Sulfuric Acid Formation', element_symbol: 'SO2', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sulfuric Acid Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sulfuric Acid Formation', element_symbol: 'H2SO4', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Methane Combustion', element_symbol: 'CH4', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Methane Combustion', element_symbol: 'O2', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Methane Combustion', element_symbol: 'CO2', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Methane Combustion', element_symbol: 'H2O', role: 'Product', quantity: 2.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'Na', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'NaOH', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'H2', role: 'Product', quantity: 1.0 }
]

reaction_elements.each do |re_attrs|
  reaction = Reaction.find_by(name: re_attrs[:reaction_name])
  element = Element.find_by(symbol: re_attrs[:element_symbol])
  if element.nil?
    puts "Element not found: #{re_attrs[:element_symbol]}"
  else
    ReactionElement.create!(reaction: reaction, element: element, role: re_attrs[:role], quantity: re_attrs[:quantity])
  end
end

puts 'Creating questions and answer choices…'

def create_single_choice_question(experiment, content, choices)
  question = Question.create!(experiment: experiment, content: content, question_type: 'single_choice')
  choices.each do |choice|
    AnswerChoice.create!(question: question, content: choice[:content], correct: choice[:correct])
  end
end

def create_multiple_choice_question(experiment, content, choices)
  options = choices.map { |c| c[:content] }
  correct_options = choices.select { |c| c[:correct] }.map { |c| c[:content] }

  question = Question.create!(
    experiment: experiment,
    content: content,
    question_type: 'multiple_choice',
    options: options.join(','), # join options into a comma-separated string
    correct_option: correct_options.join(',') # join correct options into a comma-separated string
  )
  
  choices.each do |choice|
    AnswerChoice.create!(question: question, content: choice[:content], correct: choice[:correct])
  end
end

def create_word_bank_question(experiment, content, options_with_correctness)
  options = options_with_correctness.map { |o| o[:content] }
  correct_options = options_with_correctness.select { |o| o[:correct] }.map { |o| o[:content] }

  Question.create!(
    experiment: experiment,
    content: content,
    question_type: 'word_bank',
    options: options,
    correct_option: correct_options.join(',')
  )
end

experiment1 = Experiment.find_by(title: 'Experiment 1: Water Formation')
experiment2 = Experiment.find_by(title: 'Experiment 2: Hydrogen Chloride Formation')
experiment3 = Experiment.find_by(title: 'Experiment 3: Sodium Chloride Formation')
experiment4 = Experiment.find_by(title: 'Experiment 4: Ammonia Formation')
experiment5 = Experiment.find_by(title: 'Experiment 5: Carbon Dioxide Formation')
experiment6 = Experiment.find_by(title: 'Experiment 6: Copper Sulfate Formation')
experiment7 = Experiment.find_by(title: 'Experiment 7: Calcium Hydroxide Formation')
experiment8 = Experiment.find_by(title: 'Experiment 8: Ethanol Formation')
experiment9 = Experiment.find_by(title: 'Experiment 9: Sulfuric Acid Formation')
experiment10 = Experiment.find_by(title: 'Experiment 10: Methane Combustion')
experiment11 = Experiment.find_by(title: 'Experiment 11: Sodium Hydroxide Formation')

create_single_choice_question(experiment1, 'What elements are needed to form water?', [
  { content: 'Hydrogen and Oxygen', correct: true },
  { content: 'Hydrogen and Nitrogen', correct: false },
  { content: 'Oxygen and Carbon', correct: false },
  { content: 'Carbon and Hydrogen', correct: false }
])

create_multiple_choice_question(experiment1, 'What are the properties of water?', [
  { content: 'Liquid at room temperature', correct: true },
  { content: 'Conducts electricity', correct: false },
  { content: 'Tasteless and odorless', correct: true },
  { content: 'Conducts something else completely', correct: false }
])

create_word_bank_question(experiment1, 'Fill in the blanks: Water is made up of two _____ atoms and one _____ atom.', [
  { content: 'Hydrogen', correct: true },
  { content: 'Oxygen', correct: true },
  { content: 'Carbon', correct: false },
  { content: 'Nitrogen', correct: false }
])

create_single_choice_question(experiment2, 'What elements are needed to form hydrochloric acid?', [
  { content: 'Hydrogen and Chlorine', correct: true },
  { content: 'Hydrogen and Oxygen', correct: false },
  { content: 'Chlorine and Sodium', correct: false },
  { content: 'Oxygen and Carbon', correct: false }
])

create_multiple_choice_question(experiment2, 'What are the properties of hydrochloric acid?', [
  { content: 'Colorless', correct: true },
  { content: 'Corrosive', correct: true },
  { content: 'Odorless', correct: false }
])

create_word_bank_question(experiment2, 'Fill in the blanks: Hydrochloric acid is made up of one _____ atom and one _____ atom.', [
  { content: 'Hydrogen', correct: true },
  { content: 'Chlorine', correct: true },
  { content: 'Carbon', correct: false },
  { content: 'Oxygen', correct: false }
])

create_single_choice_question(experiment3, 'What elements are needed to form sodium chloride?', [
  { content: 'Sodium and Chlorine', correct: true },
  { content: 'Sodium and Carbon', correct: false },
  { content: 'Chlorine and Oxygen', correct: false },
  { content: 'Sodium and Oxygen', correct: false }
])

create_multiple_choice_question(experiment3, 'What are the properties of sodium chloride?', [
  { content: 'Solid at room temperature', correct: true },
  { content: 'Conducts electricity when dissolved in water', correct: true },
  { content: 'Liquid at room temperature', correct: false }
])

create_word_bank_question(experiment3, 'Fill in the blanks: Sodium chloride is made up of one _____ atom and one _____ atom.', [
  { content: 'Sodium', correct: true },
  { content: 'Chlorine', correct: true },
  { content: 'Hydrogen', correct: false },
  { content: 'Oxygen', correct: false }
])

create_single_choice_question(experiment4, 'What elements are needed to form ammonia?', [
  { content: 'Nitrogen and Hydrogen', correct: true },
  { content: 'Nitrogen and Oxygen', correct: false },
  { content: 'Hydrogen and Oxygen', correct: false },
  { content: 'Nitrogen and Chlorine', correct: false }
])

create_multiple_choice_question(experiment4, 'What are the properties of ammonia?', [
  { content: 'Pungent smell', correct: true },
  { content: 'Colorless gas', correct: true },
  { content: 'Liquid at room temperature', correct: false }
])

create_word_bank_question(experiment4, 'Fill in the blanks: Ammonia is made up of one _____ atom and three _____ atoms.', [
  { content: 'Nitrogen', correct: true },
  { content: 'Hydrogen', correct: true },
  { content: 'Oxygen', correct: false },
  { content: 'Chlorine', correct: false }
])

create_single_choice_question(experiment5, 'What elements are needed to form carbon dioxide?', [
  { content: 'Carbon and Oxygen', correct: true },
  { content: 'Carbon and Nitrogen', correct: false },
  { content: 'Oxygen and Hydrogen', correct: false },
  { content: 'Carbon and Chlorine', correct: false }
])

create_multiple_choice_question(experiment5, 'What are the properties of carbon dioxide?', [
  { content: 'Colorless gas', correct: true },
  { content: 'Odorless', correct: true },
  { content: 'Liquid at room temperature', correct: false }
])

create_word_bank_question(experiment5, 'Fill in the blanks: Carbon dioxide is made up of one _____ atom and two _____ atoms.', [
  { content: 'Carbon', correct: true },
  { content: 'Oxygen', correct: true },
  { content: 'Hydrogen', correct: false },
  { content: 'Nitrogen', correct: false }
])

create_single_choice_question(experiment6, 'What elements are needed to form copper sulfate?', [
  { content: 'Copper and Sulfur', correct: true },
  { content: 'Copper and Sodium', correct: false },
  { content: 'Sulfur and Oxygen', correct: false },
  { content: 'Copper and Oxygen', correct: false }
])

create_multiple_choice_question(experiment6, 'What are the properties of copper sulfate?', [
  { content: 'Blue crystals', correct: true },
  { content: 'Soluble in water', correct: true },
  { content: 'Gas at room temperature', correct: false }
])

create_word_bank_question(experiment6, 'Fill in the blanks: Copper sulfate is made up of one _____ atom and one _____ atom.', [
  { content: 'Copper', correct: true },
  { content: 'Sulfur', correct: true },
  { content: 'Hydrogen', correct: false },
  { content: 'Oxygen', correct: false }
])

create_single_choice_question(experiment7, 'What elements are needed to form calcium hydroxide?', [
  { content: 'Calcium and Water', correct: true },
  { content: 'Calcium and Oxygen', correct: false },
  { content: 'Calcium and Nitrogen', correct: false },
  { content: 'Calcium and Chlorine', correct: false }
])

create_multiple_choice_question(experiment7, 'What are the properties of calcium hydroxide?', [
  { content: 'White powder', correct: true },
  { content: 'Soluble in water', correct: true },
  { content: 'Gas at room temperature', correct: false }
])

create_word_bank_question(experiment7, 'Fill in the blanks: Calcium hydroxide is made up of one _____ atom, two _____ atoms, and two _____ atoms.', [
  { content: 'Calcium', correct: true },
  { content: 'Oxygen', correct: true },
  { content: 'Hydrogen', correct: true },
  { content: 'Nitrogen', correct: false }
])

create_single_choice_question(experiment8, 'What elements are needed to form ethanol?', [
  { content: 'Ethene and Water', correct: true },
  { content: 'Ethene and Oxygen', correct: false },
  { content: 'Ethene and Nitrogen', correct: false },
  { content: 'Ethene and Chlorine', correct: false }
])

create_multiple_choice_question(experiment8, 'What are the properties of ethanol?', [
  { content: 'Colorless liquid', correct: true },
  { content: 'Flammable', correct: true },
  { content: 'Gas at room temperature', correct: false }
])

create_word_bank_question(experiment8, 'Fill in the blanks: Ethanol is made up of two _____ atoms, six _____ atoms, and one _____ atom.', [
  { content: 'Carbon', correct: true },
  { content: 'Hydrogen', correct: true },
  { content: 'Oxygen', correct: true },
  { content: 'Nitrogen', correct: false }
])

create_single_choice_question(experiment9, 'What elements are needed to form sulfuric acid?', [
  { content: 'Sulfur dioxide and Water', correct: true },
  { content: 'Sulfur dioxide and Oxygen', correct: false },
  { content: 'Sulfur dioxide and Nitrogen', correct: false },
  { content: 'Sulfur dioxide and Chlorine', correct: false }
])

create_multiple_choice_question(experiment9, 'What are the properties of sulfuric acid?', [
  { content: 'Colorless', correct: true },
  { content: 'Highly corrosive', correct: true },
  { content: 'Gas at room temperature', correct: false }
])

create_word_bank_question(experiment9, 'Fill in the blanks: Sulfuric acid is made up of two _____ atoms, one _____ atom, and four _____ atoms.', [
  { content: 'Hydrogen', correct: true },
  { content: 'Sulfur', correct: true },
  { content: 'Oxygen', correct: true },
  { content: 'Carbon', correct: false }
])

create_single_choice_question(experiment10, 'What elements are needed to combust methane?', [
  { content: 'Methane and Oxygen', correct: true },
  { content: 'Methane and Nitrogen', correct: false },
  { content: 'Methane and Hydrogen', correct: false },
  { content: 'Methane and Carbon', correct: false }
])

create_multiple_choice_question(experiment10, 'What are the products of methane combustion?', [
  { content: 'Carbon dioxide', correct: true },
  { content: 'Water', correct: true },
  { content: 'Methane', correct: false }
])

create_word_bank_question(experiment10, 'Fill in the blanks: Methane combustion produces one _____ molecule and two _____ molecules.', [
  { content: 'Carbon dioxide', correct: true },
  { content: 'Water', correct: true },
  { content: 'Oxygen', correct: false },
  { content: 'Hydrogen', correct: false }
])

create_single_choice_question(experiment11, 'What elements are needed to form sodium hydroxide?', [
  { content: 'Sodium and Water', correct: true },
  { content: 'Sodium and Oxygen', correct: false },
  { content: 'Sodium and Nitrogen', correct: false },
  { content: 'Sodium and Chlorine', correct: false }
])

create_multiple_choice_question(experiment11, 'What are the properties of sodium hydroxide?', [
  { content: 'White solid', correct: true },
  { content: 'Soluble in water', correct: true },
  { content: 'Gas at room temperature', correct: false }
])

create_word_bank_question(experiment11, 'Fill in the blanks: Sodium hydroxide is made up of one _____ atom, one _____ atom, and one _____ atom.', [
  { content: 'Sodium', correct: true },
  { content: 'Oxygen', correct: true },
  { content: 'Hydrogen', correct: true },
  { content: 'Carbon', correct: false }
])

badge_data = FetchBadgesFromCloudinary.call

Rails.logger.debug("Fetched badge data: #{badge_data}")

if badge_data.any?
  badges = Badge.create!(badge_data)
  puts "Badges seeded successfully!"

  lessons_titles_to_badges = {
    'Chemistry Basics' => badges.find { |badge| badge.title == 'New Genius' },
    'Atoms and Molecules' => badges.find { |badge| badge.title == 'Atomic Models' },
    'Periodic Table' => badges.find { |badge| badge.title == 'Expert Scientist' },
    'Chemical Bonds' => badges.find { |badge| badge.title == 'Chemistry 101 Wizard' },
    'States of Matter' => badges.find { |badge| badge.title == 'Physics Prodigy' },
    'Solutions and Mixtures' => badges.find { |badge| badge.title == 'Biology Buff' }
  }

  lessons_titles_to_badges.each do |lesson_title, badge|
    lesson = Lesson.find_by(title: lesson_title)
    lesson.update(badge: badge) if lesson && badge
  end

  puts "Badges assigned to lessons successfully!"
else
  puts "No badge data fetched from Cloudinary."
end

puts 'Seeding completed'
