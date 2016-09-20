class User < ApplicationRecord
  has_many :tasks
  has_many :collaborations
  has_many :cards, through: :collaborations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?


  private
    def set_default_role
      self.role ||= :user
    end
end
