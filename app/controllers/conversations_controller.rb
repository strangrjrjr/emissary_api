class ConversationsController < ApplicationController
    before_action :logged_in?

    def index
        conversations = Conversation.all
        conversations = conversations.select{|conversation| conversation.users.map{|user| user.id}.include?(current_user.id)}
        sorted_convos = conversations.each {|convo| convo.messages.sort_by {|msg| msg.id}}
        render json: sorted_convos
    end

    # def create
    #     conversation = Conversation.new(conversation_params)
    #     if conversation.save
    #         UserConversation.create(user_id: current_user.id, conversation_id:conversation.id)
    #        params["conversation"]["users"].each do |user|
    #             if (user["id"] != current_user.id)
    #                 UserConversation.create(user_id: user["id"], conversation_id: conversation.id)
    #             end
    #         end
    #         serialized_convo = ActiveModelSerializers::Adapter::Json.new(ConversationSerializer.new(conversation)).serializable_hash
    #         # offload broadcast to job
    #         # BROADCAST DOES NOT UPDATE DOM, WHY?
    #         ActionCable.server.broadcast "conversations_channel", serialized_convo
    #         head :ok
    #     end
    # end

    def delete
        @conversation = Conversation.find_by(conversation_params)
        if @conversation.destroy
            render json: {response: "DESTROYED"}
        else
            render json: {response: 'ERROR'}
        end
    end

    private

        def conversation_params
            params.require(:conversation).permit(:id, :title, :topic, :private, :users => [])
        end
end
