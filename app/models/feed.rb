class Feed < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :card, optional: true
  belongs_to :list, optional: true


  #user added to the #id card to the #id list
  #user deleted the #id card from #id list
  #user updated the #id card from #id list
  #user deleted the #id list
  #user created the #id list
end
