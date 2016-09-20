class User < ApplicationRecord
  has_many :tasks
  has_many :collaborations
  has_many :cards, through: :collaborations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end

  private
    def set_default_role
      self.role ||= :user
    end
end
