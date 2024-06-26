puts "Deleting all existing data..."
AnswerChoice.delete_all
Answer.delete_all
Question.delete_all
Experiment.delete_all
Lesson.delete_all
Enrollment.delete_all
Course.delete_all
UserBadge.delete_all
Badge.delete_all
Xp.delete_all
User.delete_all

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

puts 'Creating questions and answer choices...'

def create_question_with_choices(experiment, content, choices)
  question = Question.create!(experiment: experiment, content: content)
  choices.each do |choice|
    AnswerChoice.create!(question: question, content: choice[:content], correct: choice[:correct])
  end
  question
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

create_question_with_choices(experiment1, 'What happens when substance A is mixed with substance B?', [
  { content: 'It produces a gas.', correct: true },
  { content: 'It produces a liquid.', correct: false },
  { content: 'Nothing happens.', correct: false },
  { content: 'It produces a solid.', correct: false }
])

create_question_with_choices(experiment2, 'What is the atomic number of the atom model you built?', [
  { content: '8', correct: true },
  { content: '6', correct: false },
  { content: '10', correct: false },
  { content: '12', correct: false }
])

create_question_with_choices(experiment3, 'What is the symbol for element X in the periodic table?', [
  { content: 'O', correct: true },
  { content: 'C', correct: false },
  { content: 'N', correct: false },
  { content: 'H', correct: false }
])

create_question_with_choices(experiment4, 'What type of bond is found in compound Y?', [
  { content: 'Ionic bond.', correct: true },
  { content: 'Covalent bond.', correct: false },
  { content: 'Metallic bond.', correct: false },
  { content: 'Hydrogen bond.', correct: false }
])

create_question_with_choices(experiment5, 'What state changes did you observe during the experiment?', [
  { content: 'Solid to liquid.', correct: true },
  { content: 'Liquid to gas.', correct: false },
  { content: 'Gas to liquid.', correct: false },
  { content: 'Solid to gas.', correct: false }
])

create_question_with_choices(experiment6, 'What are the properties of the solution you prepared?', [
  { content: 'It is a clear solution.', correct: true },
  { content: 'It is a cloudy solution.', correct: false },
  { content: 'It is a colored solution.', correct: false },
  { content: 'It is a suspension.', correct: false }
])

create_question_with_choices(experiment7, 'How does temperature affect the reaction rate of substance C and D?', [
  { content: 'The reaction rate increases with temperature.', correct: true },
  { content: 'The reaction rate decreases with temperature.', correct: false },
  { content: 'The reaction rate stays the same.', correct: false },
  { content: 'The reaction rate first increases then decreases.', correct: false }
])

create_question_with_choices(experiment8, 'Name the hydrocarbons identified in the experiment.', [
  { content: 'Methane, Ethane, Propane', correct: true },
  { content: 'Methane, Ethene, Propyne', correct: false },
  { content: 'Methane, Ethanol, Propane', correct: false },
  { content: 'Methane, Ethane, Propanol', correct: false }
])

create_question_with_choices(experiment9, 'What was the concentration of the acid/base after titration?', [
  { content: '0.1 M', correct: true },
  { content: '0.5 M', correct: false },
  { content: '1.0 M', correct: false },
  { content: '2.0 M', correct: false }
])

create_question_with_choices(experiment10, 'What was the heat change measured during the reaction?', [
  { content: '5 kJ', correct: true },
  { content: '10 kJ', correct: false },
  { content: '15 kJ', correct: false },
  { content: '20 kJ', correct: false }
])

create_question_with_choices(experiment11, 'What were the results of the electrolysis experiment?', [
  { content: 'Produced hydrogen gas.', correct: true },
  { content: 'Produced oxygen gas.', correct: false },
  { content: 'Produced carbon dioxide.', correct: false },
  { content: 'Produced nitrogen gas.', correct: false }
])
