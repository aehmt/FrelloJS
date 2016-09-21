class Card < ApplicationRecord
  belongs_to :task, optional: true
  has_many :collaborations
  has_many :collaborators, through: :collaborations, class: "User"
  has_many :feeds
end
