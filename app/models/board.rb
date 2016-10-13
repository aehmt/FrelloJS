class Board < ApplicationRecord
  belongs_to :user, optional: true
  has_many :lists
  has_many :feeds

  validates_length_of :name, maximum: 30, message: "board must be a maximium of 30 characters"
  # validates_uniqueness_of :name


end
