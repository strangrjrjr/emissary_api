class ConversationsController < ApplicationController
    before_action :logged_in?

    def index
        Conversation.get_user_conversations(current_user)
    end

    def create
        conversation = Conversation.new(conversation_params)
        if conversation.save
            stripped = conversation.users {|user| user.id = nil}
            serialized_convo = ActiveModelSerializers::Adapter::Json.new(ConversationSerializer.new(conversation)).serializable_hash
            # offload broadcast to job
            ActionCable.server.broadcast 'conversations_channel', serialized_convo
            head :ok
        end
    end

    def delete
        conversation = Conversation.find(conversation_params)
        conversation.destroy
    end

    private

        def conversation_params
            params.require(:conversation).permit(:id, :title, :topic, :private)
        end
end
