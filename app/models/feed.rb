class Feed < ApplicationRecord
  belongs_to :user
  belongs_to :card
  belongs_to :list


  #user added to the #id card to the #id list
  #user deleted the #id card from #id list
  #user updated the #id card from #id list
  #user deleted the #id list
  #user created the #id list
end
