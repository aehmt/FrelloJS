class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :user_id, :private, :starred
end
