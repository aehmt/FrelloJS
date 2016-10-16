class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :position, :cards, :board_id

  has_many :cards, serializer: CardSerializer
end