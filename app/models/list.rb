class List < ApplicationRecord
  belongs_to :board, optional: true
  has_many :cards
  has_many :collaborators, through: :cards
  has_many :feeds

  def self.overdue
    all.where("duedate < ?", Time.now)
  end

  def self.almost_overdue
    all.where("duedate > ? and duedate < ?", 30.minutes.ago, Time.now)
  end
end
