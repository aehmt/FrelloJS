class Feed < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :user, optional: true
  belongs_to :card, optional: true
  belongs_to :list, optional: true
  belongs_to :board, optional: true


  #user added to the #id card to the #id list
  #user deleted the #id card from #id list
  #user updated the #id card from #id list
  #user deleted the #id list
  #user created the #id list
  def time_ago
    "#{time_ago_in_words(self.created_at)} ago"
  end
end
