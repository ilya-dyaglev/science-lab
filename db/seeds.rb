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
  { lesson_title: 'Chemistry Basics', title: 'Experiment 1: Simple Chemical Reaction', instructions: 'Mix substance A with substance B.' },
  { lesson_title: 'Atoms and Molecules', title: 'Experiment 2: Atom Model', instructions: 'Build a model of an atom using the given materials.' },
  { lesson_title: 'Periodic Table', title: 'Experiment 3: Element Identification', instructions: 'Identify different elements using the periodic table.' },
  { lesson_title: 'Chemical Bonds', title: 'Experiment 4: Bond Types', instructions: 'Identify the types of bonds in different compounds.' },
  { lesson_title: 'States of Matter', title: 'Experiment 5: State Changes', instructions: 'Observe and record changes in state of matter.' },
  { lesson_title: 'Solutions and Mixtures', title: 'Experiment 6: Solution Preparation', instructions: 'Prepare a solution and record its properties.' },
  { lesson_title: 'Chemical Reactions', title: 'Experiment 7: Reaction Rate', instructions: 'Measure the reaction rate of substance C with substance D.' },
  { lesson_title: 'Organic Chemistry', title: 'Experiment 8: Hydrocarbons', instructions: 'Identify different hydrocarbons from the given samples.' },
  { lesson_title: 'Acids and Bases', title: 'Experiment 9: Acid-Base Titration', instructions: 'Perform a titration to determine the concentration of an acid or base.' },
  { lesson_title: 'Thermochemistry', title: 'Experiment 10: Heat Measurement', instructions: 'Measure the heat change in a chemical reaction.' },
  { lesson_title: 'Electrochemistry', title: 'Experiment 11: Electrolysis', instructions: 'Perform electrolysis and observe the results.' }
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
  { name: 'Oxygen', symbol: 'O', atomic_number: 8, atomic_weight: 15.999, period: 2, group: 16, category: 'Nonmetal', state_at_room_temp: 1, density: 0.001429, melting_point: -218.79, boiling_point: -182.95 }
]

elements.each do |element_attrs|
  Element.create!(element_attrs)
end

puts 'Creating reactions...'
reactions = [
  { name: 'Water Formation', description: 'Hydrogen reacts with oxygen to form water.' },
  { name: 'Carbon Dioxide Formation', description: 'Carbon reacts with oxygen to form carbon dioxide.' }
]

reactions.each do |reaction_attrs|
  Reaction.create!(reaction_attrs)
end

puts 'Creating reaction elements...'
reaction_elements = [
  { reaction_name: 'Water Formation', element_symbol: 'H', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Water Formation', element_symbol: 'O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Water Formation', element_symbol: 'H2O', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'C', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'O', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'CO2', role: 'Product', quantity: 1.0 }
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

puts 'Creating questions and answer choices...'

def create_single_choice_question(experiment, content, choices)
  question = Question.create!(experiment: experiment, content: content, question_type: 'single_choice')
  choices.each do |choice|
    AnswerChoice.create!(question: question, content: choice[:content], correct: choice[:correct])
  end
end

def create_multiple_choice_question(experiment, content, choices)
  question = Question.create!(experiment: experiment, content: content, question_type: 'multiple_choice', options: choices.map { |c| c[:content] }, correct_option: choices.select { |c| c[:correct] }.map { |c| c[:content] }.join(','))
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

experiment1 = Experiment.find_by(title: 'Experiment 1: Simple Chemical Reaction')
experiment2 = Experiment.find_by(title: 'Experiment 2: Atom Model')
experiment3 = Experiment.find_by(title: 'Experiment 3: Element Identification')
experiment4 = Experiment.find_by(title: 'Experiment 4: Bond Types')
experiment5 = Experiment.find_by(title: 'Experiment 5: State Changes')
experiment6 = Experiment.find_by(title: 'Experiment 6: Solution Preparation')
experiment7 = Experiment.find_by(title: 'Experiment 7: Reaction Rate')
experiment8 = Experiment.find_by(title: 'Experiment 8: Hydrocarbons')
experiment9 = Experiment.find_by(title: 'Experiment 9: Acid-Base Titration')
experiment10 = Experiment.find_by(title: 'Experiment 10: Heat Measurement')
experiment11 = Experiment.find_by(title: 'Experiment 11: Electrolysis')

gen_single_choice = [
  { content: 'It produces a gas.', correct: true },
  { content: 'It produces a liquid.', correct: false },
  { content: 'Nothing happens.', correct: false },
  { content: 'It produces a solid.', correct: false }
]

gen_multi_choice = [
  { content: '1 (Hydrogen)', correct: true },
  { content: '2 (Helium)', correct: true },
  { content: '6 (Carbon)', correct: true },
  { content: '7 (Nitrogen)', correct: false }
]

gen_word_bank = [
    { content: 'H', correct: true },
    { content: 'He', correct: true },
    { content: 'C', correct: true },
    { content: 'O', correct: true }
]

create_single_choice_question(experiment1, 'What happens when substance A is mixed with substance B?', gen_single_choice)

create_multiple_choice_question(experiment1, 'Select the correct atomic numbers for the given elements.',gen_multi_choice)

create_word_bank_question(
  experiment1,
  'Fill in the blanks with the correct element symbols. (Hint: Hydrogen, Helium, Carbon, Oxygen)',
  gen_word_bank
)

create_single_choice_question(experiment2, 'What happens when substance A is mixed with substance B?', gen_single_choice)

create_multiple_choice_question(experiment2, 'Select the correct atomic numbers for the given elements.',gen_multi_choice)

create_word_bank_question(
  experiment2,
  'Fill in the blanks with the correct element symbols. (Hint: Hydrogen, Helium, Carbon, Oxygen)',
  gen_word_bank
)

create_single_choice_question(experiment3, 'What happens when substance A is mixed with substance B?', gen_single_choice)

create_multiple_choice_question(experiment3, 'Select the correct atomic numbers for the given elements.',gen_multi_choice)

create_word_bank_question(
  experiment3,
  'Fill in the blanks with the correct element symbols. (Hint: Hydrogen, Helium, Carbon, Oxygen)',
  gen_word_bank
)

create_single_choice_question(experiment4, 'What type of bond is found in compound Y?', [
  { content: 'Ionic bond.', correct: true },
  { content: 'Covalent bond.', correct: false },
  { content: 'Metallic bond.', correct: false },
  { content: 'Hydrogen bond.', correct: false }
])

create_single_choice_question(experiment5, 'What state changes did you observe during the experiment?', [
  { content: 'Solid to liquid.', correct: true },
  { content: 'Liquid to gas.', correct: false },
  { content: 'Gas to liquid.', correct: false },
  { content: 'Solid to gas.', correct: false }
])

create_single_choice_question(experiment6, 'What are the properties of the solution you prepared?', [
  { content: 'It is a clear solution.', correct: true },
  { content: 'It is a cloudy solution.', correct: false },
  { content: 'It is a colored solution.', correct: false },
  { content: 'It is a suspension.', correct: false }
])

create_single_choice_question(experiment7, 'How does temperature affect the reaction rate of substance C and D?', [
  { content: 'The reaction rate increases with temperature.', correct: true },
  { content: 'The reaction rate decreases with temperature.', correct: false },
  { content: 'The reaction rate stays the same.', correct: false },
  { content: 'The reaction rate first increases then decreases.', correct: false }
])

create_single_choice_question(experiment8, 'Name the hydrocarbons identified in the experiment.', [
  { content: 'Methane, Ethane, Propane', correct: true },
  { content: 'Methane, Ethene, Propyne', correct: false },
  { content: 'Methane, Ethanol, Propane', correct: false },
  { content: 'Methane, Ethane, Propanol', correct: false }
])

create_single_choice_question(experiment9, 'What was the concentration of the acid/base after titration?', [
  { content: '0.1 M', correct: true },
  { content: '0.5 M', correct: false },
  { content: '1.0 M', correct: false },
  { content: '2.0 M', correct: false }
])

create_single_choice_question(experiment10, 'What was the heat change measured during the reaction?', [
  { content: '5 kJ', correct: true },
  { content: '10 kJ', correct: false },
  { content: '15 kJ', correct: false },
  { content: '20 kJ', correct: false }
])

create_single_choice_question(experiment11, 'What were the results of the electrolysis experiment?', [
  { content: 'Produced hydrogen gas.', correct: true },
  { content: 'Produced oxygen gas.', correct: false },
  { content: 'Produced carbon dioxide.', correct: false },
  { content: 'Produced nitrogen gas.', correct: false }
])

badges = Badge.create!([
  { title: "New Genius", description: "Congratulations, you have completed your first lesson! Keep it up.", image: File.open(Rails.root.join("app/assets/images/badges/badge1.png")) },
  { title: "Atomic Models", description: "You have learnt more about atomic models.", image: File.open(Rails.root.join("app/assets/images/badges/badge2.png")) },
  { title: "Expert Scientist", description: "Awarded to scientists who complete 10 courses with distinction.", image: File.open(Rails.root.join("app/assets/images/badges/badge3.png")) },
  { title: "Chemistry 101 Wizard", description: "You have completed your first chemistry lesson! Keep it up.", image: File.open(Rails.root.join("app/assets/images/badges/badge4.png")) },
  { title: "Physics Prodigy", description: "You have mastered the basics of physics.", image: File.open(Rails.root.join("app/assets/images/badges/badge5.png")) },
  { title: "Biology Buff", description: "You have shown exceptional understanding in biology.", image: File.open(Rails.root.join("app/assets/images/badges/badge6.png")) },
  { title: "Mathematics Marvel", description: "You have excelled in mathematics lessons.", image: File.open(Rails.root.join("app/assets/images/badges/badge7.png")) }
])

puts "Badges seeded successfully!"

lessons_titles_to_badges = {
  'Chemistry Basics' => badges[0],
  'Atoms and Molecules' => badges[1],
  'Periodic Table' => badges[2],
  'Chemical Bonds' => badges[3],
  'States of Matter' => badges[4],
  'Solutions and Mixtures' => badges[5]
}

lessons_titles_to_badges.each do |lesson_title, badge|
  lesson = Lesson.find_by(title: lesson_title)
  lesson.update(badge: badge) if lesson
end

puts "Seeding completed"