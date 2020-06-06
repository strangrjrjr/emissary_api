class Conversation < ApplicationRecord
    has_many :user_conversations
    has_many :messages, dependent: :destroy
    has_many :users, through: :user_conversations
end 
