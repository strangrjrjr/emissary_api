class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :topic, :private
end
