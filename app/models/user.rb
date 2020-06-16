class User < ApplicationRecord
    has_secure_password
    has_many :user_conversations
    has_many :conversations, through: :user_conversations
    has_many :messages
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    def online?
        !Redis.new.get("user_#{self.id}_online").nil?
    end

end
