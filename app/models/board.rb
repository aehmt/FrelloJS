class Board < ApplicationRecord
  belongs_to :user, optional: true
  has_many :lists
  has_many :feeds
end
