# frozen_string_literal: true

class ChatsController < ApplicationController
  # GET /chats
  def index
    chats = current_user.chats
    render json: ChatSerializer.new(chats).serialized_json, status: :ok
  end

  # POST /chats
  def create
    head Chats::CreateWith.call current_user, params[:user_id].to_i
  end
end
