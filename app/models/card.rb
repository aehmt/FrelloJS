class Card < ApplicationRecord
  belongs_to :list, optional: true
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user
  has_many :feeds
end
