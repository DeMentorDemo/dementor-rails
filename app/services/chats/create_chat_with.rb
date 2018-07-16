# frozen_string_literal: true

module Chats
  class CreateChatWith
    include Callable

    def initialize(current_user, chat_with_user_id)
      @current_user = current_user
      @chat_with_user_id = chat_with_user_id
    end

    def call
      name = "#{current_user.name} - #{chat_with_user.name}"
      chat = Chat.new name: name
      chat.users << current_user << chat_with_user
      chat.save ? :created : :bad_request
    end

    private

    attr_reader :current_user, :chat_with_user_id

    def chat_with_user
      @chat_with_user ||= User.find chat_with_user_id
    end
  end
end
