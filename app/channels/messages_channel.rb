# frozen_string_literal: true

class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatRoom-#{params[:room_id]}" if params[:room_id].present?
  end
end
