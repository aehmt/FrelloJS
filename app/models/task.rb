class Task < ApplicationRecord
  belongs_to :board
  has_many :cards
  has_many :feeds
end
