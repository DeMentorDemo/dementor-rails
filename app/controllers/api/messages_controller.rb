# frozen_string_literal: true

module Api
  class MessagesController < ApplicationController
    # GET /api/chats/:chat_id/messages
    def index
      messages = Message.where(chat_id: params[:chat_id])
      render json: MessageSerializer.new(messages).serialized_json, status: :ok
    end

    # POST /api/chats/:chat_id/messages
    def create
      message = Message.new message_params
      if message.save
        ActionCable.server.broadcast 'messages', MessageSerializer.new(message).serializable_hash
        head :created
      else
        head :bad_request
      end
    end

    private

    def message_params
      params.require(:message).permit(:user_id, :chat_id, :text)
    end
  end
end
