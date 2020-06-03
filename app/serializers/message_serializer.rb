class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text
  has_one :user
  has_one :conversation
end
