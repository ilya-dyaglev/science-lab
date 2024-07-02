class Element < ApplicationRecord
  has_many :reaction_elements
  has_many :reactions, through: :reaction_elements
end
