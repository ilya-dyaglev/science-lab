class Reaction < ApplicationRecord
  has_many :reaction_elements
  has_many :elements, through: :reaction_elements
end
