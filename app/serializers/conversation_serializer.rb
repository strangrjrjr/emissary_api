class ConversationSerializer < ActiveModel::Serializer
  # tried adding users and messages
  attributes :id, :title, :topic, :private, :users, :messages
end
