class BoardSerializer < ActiveModel::Serializer
  attributes :id, :color, :user_id, :private, :starred
end
