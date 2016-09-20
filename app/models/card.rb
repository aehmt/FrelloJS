class Card < ApplicationRecord
  belongs_to :task
  has_many :collaborations
  has_many :collaborators, through: :collaborations, class: "User"
end
