class Card < ApplicationRecord
  belongs_to :task, optional: true
  has_many :collaborations
  has_many :collaborators, through: :collaborations, class_name: "User"
  has_many :feeds
end
