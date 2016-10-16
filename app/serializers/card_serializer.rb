class CardSerializer < ActiveModel::Serializer
  attributes :id, :content, :checked, :list_id
end