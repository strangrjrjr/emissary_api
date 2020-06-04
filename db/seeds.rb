# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UserConversation.destroy_all
Message.destroy_all
User.destroy_all
Conversation.destroy_all

User.create(username: "test1", password: "test", email:"test1@test.com")
User.create(username: "test2", password: "test", email:"tes2t@test.com")
User.create(username: "test3", password: "test", email:"test3@test.com")
puts "USER CREATION COMPLETE"

Conversation.create(title: "two person", topic: "testing", private: false)
Conversation.create(title: "three person", topic: "testing again", private: false)
puts "CONVERSATION CREATION COMPLETE"


UserConversation.create(creator_id: User.first.id, user_id: User.first.id, conversation_id: Conversation.first.id)
UserConversation.create(creator_id: User.first.id, user_id: User.second.id, conversation_id: Conversation.first.id)
puts "TWO PERSON CONVERSATION ASSOCIATED"

UserConversation.create(creator_id: User.second.id, user_id: User.first.id, conversation_id: Conversation.second.id)
UserConversation.create(creator_id: User.second.id, user_id: User.second.id, conversation_id: Conversation.second.id)
UserConversation.create(creator_id: User.second.id, user_id: User.third.id, conversation_id: Conversation.second.id)
puts "THREE PERSON CONVERSATION ASSOCIATED"
puts "SEEDS COMPLETE"
