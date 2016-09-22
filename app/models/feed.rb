class Feed < ApplicationRecord
  belongs_to :user
  belongs_to :card
  belongs_to :list
end
