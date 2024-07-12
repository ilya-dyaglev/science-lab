ReactionElement.delete_all
Reaction.delete_all
Element.delete_all
Badge.delete_all
User.delete_all

puts 'Creating elements...'
elements = [
  { name: 'Hydrogen', symbol: 'H', atomic_number: 1, atomic_weight: 1.008, period: 1, group: 1, category: 'Nonmetal', state_at_room_temp: 1, density: 0.00008988, melting_point: -259.14, boiling_point: -252.87 },
  { name: 'Helium', symbol: 'He', atomic_number: 2, atomic_weight: 4.002602, period: 1, group: 18, category: 'Noble Gas', state_at_room_temp: 1, density: 0.0001785, melting_point: -272.20, boiling_point: -268.93 },
  { name: 'Lithium', symbol: 'Li', atomic_number: 3, atomic_weight: 6.94, period: 2, group: 1, category: 'Alkali Metal', state_at_room_temp: 2, density: 0.534, melting_point: 180.54, boiling_point: 1342 },
  { name: 'Beryllium', symbol: 'Be', atomic_number: 4, atomic_weight: 9.0122, period: 2, group: 2, category: 'Alkaline Earth Metal', state_at_room_temp: 2, density: 1.85, melting_point: 1287, boiling_point: 2970 },
  { name: 'Boron', symbol: 'B', atomic_number: 5, atomic_weight: 10.81, period: 2, group: 13, category: 'Metalloid', state_at_room_temp: 2, density: 2.34, melting_point: 2076, boiling_point: 3927 },
  { name: 'Carbon', symbol: 'C', atomic_number: 6, atomic_weight: 12.011, period: 2, group: 14, category: 'Nonmetal', state_at_room_temp: 2, density: 2.267, melting_point: 3550, boiling_point: 4027 },
  { name: 'Nitrogen', symbol: 'N', atomic_number: 7, atomic_weight: 14.007, period: 2, group: 15, category: 'Nonmetal', state_at_room_temp: 1, density: 0.0012506, melting_point: -210.1, boiling_point: -195.79 },
  { name: 'Oxygen', symbol: 'O', atomic_number: 8, atomic_weight: 15.999, period: 2, group: 16, category: 'Nonmetal', state_at_room_temp: 1, density: 0.001429, melting_point: -218.79, boiling_point: -182.95 },
  { name: 'Fluorine', symbol: 'F', atomic_number: 9, atomic_weight: 18.998, period: 2, group: 17, category: 'Halogen', state_at_room_temp: 1, density: 0.001696, melting_point: -219.67, boiling_point: -188.11 },
  { name: 'Neon', symbol: 'Ne', atomic_number: 10, atomic_weight: 20.180, period: 2, group: 18, category: 'Noble Gas', state_at_room_temp: 1, density: 0.0008999, melting_point: -248.59, boiling_point: -246.08 },
  { name: 'Sodium', symbol: 'Na', atomic_number: 11, atomic_weight: 22.99, period: 3, group: 1, category: 'Alkali Metal', state_at_room_temp: 2, density: 0.968, melting_point: 97.72, boiling_point: 883 },
  { name: 'Sulfur', symbol: 'S', atomic_number: 16, atomic_weight: 32.06, period: 3, group: 16, category: 'Nonmetal', state_at_room_temp: 2, density: 2.067, melting_point: 115.21, boiling_point: 444.6 },
  { name: 'Calcium', symbol: 'Ca', atomic_number: 20, atomic_weight: 40.078, period: 4, group: 2, category: 'Alkaline Earth Metal', state_at_room_temp: 2, density: 1.54, melting_point: 842, boiling_point: 1484 },
  { name: 'Copper', symbol: 'Cu', atomic_number: 29, atomic_weight: 63.546, period: 4, group: 11, category: 'Transition Metal', state_at_room_temp: 2, density: 8.96, melting_point: 1084.62, boiling_point: 2562 }
]

# elements.each do |element_attrs|
#   Element.create!(element_attrs)
# end

puts 'Creating reactions...'
reactions = [
  { name: 'Water Formation', description: 'Hydrogen reacts with oxygen to form water.', symbol: 'H2O' },
  { name: 'Sodium Chloride Formation', description: 'Sodium reacts with chlorine to form sodium chloride.', symbol: 'NaCl' },
  { name: 'Hydrochloric Acid Formation', description: 'Hydrogen reacts with chlorine to form hydrochloric acid.', symbol: 'HCl' },
  { name: 'Sodium Hydroxide Formation', description: 'Sodium reacts with water to form sodium hydroxide.', symbol: 'NaOH' },
  { name: 'Ammonia Formation', description: 'Nitrogen reacts with hydrogen to form ammonia.', symbol: 'NH3' },
  { name: 'Ethanol Formation', description: 'Ethene reacts with water to form ethanol.', symbol: 'C2H5OH' },
  { name: 'Sulfuric Acid Formation', description: 'Sulfur dioxide reacts with water to form sulfuric acid.', symbol: 'H2SO4' },
  { name: 'Glucose Formation', description: 'Glucose is formed from carbon, hydrogen, and oxygen.', symbol: 'C6H12O6' },
  { name: 'Carbon Dioxide Formation', description: 'Carbon reacts with oxygen to form carbon dioxide.', symbol: 'CO2' },
  { name: 'Calcium Carbonate Formation', description: 'Calcium reacts with carbon dioxide to form calcium carbonate.', symbol: 'CaCO3' }
]
#
# reactions.each do |reaction_attrs|
#   Reaction.create!(reaction_attrs)
# end

element_image_data = FetchElementImagesFromCloudinary.call

Rails.logger.debug("Fetched element image data: #{element_image_data}")

  if element_image_data.any?
    element_image_data.each do |image_data|
      puts image_data
      element = elements.find { |e| e[:symbol].to_s.downcase == image_data[:symbol] }
      if element
        element = element.update(image_url: image_data[:image_url])
        puts element
        Rails.logger.debug("Updated element: #{element[:symbol]} with image URL: #{image_data[:image_url]}")
          Element.create!(element)
      end
    end
    puts "Element images updated successfully!"
  else
    puts "No element image data fetched from Cloudinary."
  end

products_image_data = FetchProductsFromCloudinary.call

if products_image_data.any?
  products_image_data.each do |image_data|
    puts image_data
    product = reactions.find { |e| e[:symbol].to_s.downcase == image_data[:symbol] }
    if product
      product = product.update(image_url: image_data[:image_url])
      puts product
      Rails.logger.debug("Updated element: #{product[:symbol]} with image URL: #{image_data[:image_url]}")
      Reaction.create!(product)
    end
  end
  puts "Element images updated successfully!"
else
  puts "No element image data fetched from Cloudinary."
end

puts 'Creating reaction elements...'

reaction_elements_data = [
  { reaction_name: 'Water Formation', element_symbol: 'H', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Water Formation', element_symbol: 'O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Water Formation', element_symbol: 'H2O', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Sodium Chloride Formation', element_symbol: 'Na', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Chloride Formation', element_symbol: 'Cl', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Chloride Formation', element_symbol: 'NaCl', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Hydrochloric Acid Formation', element_symbol: 'H', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Hydrochloric Acid Formation', element_symbol: 'Cl', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Hydrochloric Acid Formation', element_symbol: 'HCl', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'Na', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sodium Hydroxide Formation', element_symbol: 'NaOH', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Ammonia Formation', element_symbol: 'N', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Ammonia Formation', element_symbol: 'H', role: 'Reactant', quantity: 3.0 },
  { reaction_name: 'Ammonia Formation', element_symbol: 'NH3', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Ethanol Formation', element_symbol: 'C2H4', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Ethanol Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Ethanol Formation', element_symbol: 'C2H5OH', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Sulfuric Acid Formation', element_symbol: 'SO2', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sulfuric Acid Formation', element_symbol: 'H2O', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Sulfuric Acid Formation', element_symbol: 'H2SO4', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Glucose Formation', element_symbol: 'C', role: 'Reactant', quantity: 6.0 },
  { reaction_name: 'Glucose Formation', element_symbol: 'H', role: 'Reactant', quantity: 12.0 },
  { reaction_name: 'Glucose Formation', element_symbol: 'O', role: 'Reactant', quantity: 6.0 },
  { reaction_name: 'Glucose Formation', element_symbol: 'C6H12O6', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'C', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'O', role: 'Reactant', quantity: 2.0 },
  { reaction_name: 'Carbon Dioxide Formation', element_symbol: 'CO2', role: 'Product', quantity: 1.0 },
  { reaction_name: 'Calcium Carbonate Formation', element_symbol: 'Ca', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Calcium Carbonate Formation', element_symbol: 'CO2', role: 'Reactant', quantity: 1.0 },
  { reaction_name: 'Calcium Carbonate Formation', element_symbol: 'CaCO3', role: 'Product', quantity: 1.0 }
]

def create_reaction_elements(reaction_elements_data)
  reaction_elements_data.each do |data|
    reaction = Reaction.find_by(name: data[:reaction_name])
    element = Element.find_by(symbol: data[:element_symbol])

    if reaction.nil?
      puts "Reaction not found for data: #{data}"
    end

    if element.nil?
      puts "Element not found for data: #{data}"
    end

    if reaction && element
      ReactionElement.create!(
        reaction: reaction,
        element: element,
        role: data[:role],
        quantity: data[:quantity],
        reaction_name: data[:reaction_name],
        element_symbol: data[:element_symbol]
      )
    else
      puts "Skipping creation for data: #{data}"
    end
  end
end

# Call the function with the provided data
create_reaction_elements(reaction_elements_data)

puts 'Finished creating reaction elements.'

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
  puts "Badges assigned to lessons successfully!"
else
  puts "No badge data fetched from Cloudinary."
end
