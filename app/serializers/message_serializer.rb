# frozen_string_literal: true

class MessageSerializer < ApplicationSerializer
  attributes :user_id, :chat_id, :text, :created_at, :updated_at
end
