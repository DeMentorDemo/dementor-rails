# frozen_string_literal: true

module Messages
  class Broadcast
    include Callable

    def call
      ActionCable.server.broadcast build_room_id(message.chat_id), MessageSerializer.new(message).serializable_hash
    end

    private

    attr_reader :message

    def initialize(message)
      @message = message
    end

    def build_room_id(id)
      "ChatRoom-#{id}"
    end
  end
end
