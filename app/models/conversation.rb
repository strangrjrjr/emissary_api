class Conversation < ApplicationRecord
    has_many :user_conversations
    has_many :messages, dependent: :destroy
    has_many :users, through: :user_conversations

    def self.get_user_conversations(user)
        conversations = conversations.select{|conversation| conversation.users.map{|user| user.id}.include?(current_user.id)}
        sorted_convos = conversations.each {|convo| convo.messages.sort_by {|msg| msg.id}}
        render json: sorted_convos
    end
end
