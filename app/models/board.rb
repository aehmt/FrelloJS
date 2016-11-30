class Board < ApplicationRecord
  belongs_to :user
  has_many :lists
  has_many :feeds
  has_many :collaborators, through: :lists

  validates_length_of :name, minimum: 0, maximum: 30, message: "board must be a maximium of 30 characters"
  # validates_uniqueness_of :name


end
